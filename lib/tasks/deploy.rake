$appname = 'ratefood'
$svc_user = 'srv_des'
$data_dir = '/data/drw/' + $appname
$ruby_version = '2.5.0'
$ports = {
  production: 3000,
  uat: 3002,
  test: 3003
}

# Four locations in play here...
# 1) The current directory - a Git repo from which we're deploying
# 2) The destination for the app - /site/drw/<appname>/<some-sha>, symlinked as /site/drw/<appname>/current
1# 3) The Runit "available" service dir - /site/drw/service-srv_des-available/<appname>
# 4) The Runit-managed "live" service dir - /site/drw/service-srv_des/<appname>, ultimately a symlink to "available"
#
# Summary: Pull down newest code, stop the service, copy the code to destination, refresh Runit service "available" dir,
#   and symlink "live" to "available" (after the pattern of Apache and Nginx website configs).
#
def deploy deploy_mode='development'
  # Assumes...
  # - Current directory is a viable git repo
  # - the desired Ruby is in the PATH in runit/run
  # - Bundler is installed
  # - /site/drw exists and is writable by current user
  # - Runit is installed and configured DES-like
  puts "Deploying '#{$appname}' to #{deploy_mode}..."

  sha = `git rev-parse --short HEAD`.strip
  puts "SHA = '#{sha}'"

  appname = deploy_mode==:production ? $appname : "#{$appname}-#{deploy_mode}"
  deploy_root = "/site/drw/#{appname}"
  runit_root = "/site/drw/service-#{$svc_user}"
  runit_available_root = "#{runit_root}-available"
  runit_avail_app = "#{runit_available_root}/#{appname}"

  dest = "#{deploy_root}/#{sha}"
  if File.exist? dest
    puts "#{sha} is already deployed"
    exit 0
  end

  # Copy the new version into place (we say './log' here because we *don't* want to exclude the runit/log dir).
  puts `rsync -az . #{dest} --exclude=.git --exclude=vendor --exclude='log/*.log' --exclude=uploads --exclude=public/uploads`

  # Is there already a vendor directory in current?  Let's copy it, to save time...
  if File.exist? "#{deploy_root}/current/vendor"
    puts `rsync -az "#{deploy_root}/current/vendor" #{dest}`
  end

  # Do bundle install'ing before bringing down the app, since it's really slow...
  cd dest do
    # Necessary when running inside bundle exec (e.g., with 'bundle exec rake ...').
    # More info here: http://bundler.io/man/bundle-exec.1.html
    Bundler.with_clean_env do
      sh "/site/apps/ruby-#{$ruby_version}/bin/bundle install --path vendor/bundle --without test"
      sh 'bundle exec rake assets:precompile'
    end
  end

  cd deploy_root do
    mkdir_p 'shared/uploads'  # Where images will go.
    puts `ln -nsf #{sha} current`
  end

  cd dest do
    # Set up the symlinks for managing images in the shared directory.
    puts `ln -nsf ../shared/uploads`
    mkdir_p 'public'
    cd 'public' do
      puts `ln -nsf ../uploads`
    end
  end

  # Remove the symlink, prompting Runit to stop <appname> and all related processes
  puts `sv down #{appname}`  # Make sure the app goes down
  sleep 2 # Give Runit time to process the request

  puts `rm -rf #{runit_avail_app}`
  puts `rm -f #{runit_root}/#{appname}`
  [ $data_dir, runit_root, "#{runit_avail_app}/log", dest].each do |dir|
    mkdir_p dir
  end

  # Set up the Runit service files in the "available" directory/run...
  puts `cp -r #{deploy_root}/current/runit/* #{runit_avail_app}`

  cd "#{runit_avail_app}/log" do
    # Tweak the log/run file to reflect the actual appname
    puts `perl -pi -e 's/#{$appname}(-\w+)?/#{appname}/g' run`
  end

  if File.exist? "#{runit_avail_app}/log-config"  # Update logging config, if there is one.
    puts `cp #{runit_avail_app}/log-config /sitelogs/drw/#{appname}/config`
  end

  cd runit_avail_app do
    mkdir_p 'env'
    `echo #{$ruby_version} > env/RUBY_VERSION`
    `echo #{deploy_mode} > env/RAILS_ENV` # Set mode (production or development)
    `echo #{deploy_root}/current > env/RUN_DIR` # Tell Runit where the app lives
    `echo #{$ports[deploy_mode]} > env/DRW_EVENTS_PORT` # Which port to run the app on
    `echo /home/#{$svc_user} > env/HOME` # For Bundler's sanity
    `echo #{ENV['LOGNAME']} > env/LOGNAME` # Since Runit won't have this in its env
    if ENV['SECRET_KEY_BASE']
      `echo #{ENV['SECRET_KEY_BASE']} > env/SECRET_KEY_BASE`
    else
      # Make one up ...
      `head /dev/urandom | md5sum - | cut -d' ' -f1 > env/SECRET_KEY_BASE`
    end
    if ENV['DRW_EVENTS_DATABASE_PASSWORD']
      `echo #{ENV['DRW_EVENTS_DATABASE_PASSWORD']} > env/DRW_EVENTS_DATABASE_PASSWORD`
    else
      if :production==deploy_mode
        puts "WARNING: Environment variable DRW_EVENTS_DATABASE_PASSWORD for production DB is not set.  This is probably not OK."
      end
    end
  end

  # Update the logging config...
  mkdir_p "/sitelogs/drw/#{appname}"
  puts `mv #{runit_avail_app}/log-config /sitelogs/drw/#{appname}/config`

  # Tell Runit to set it all in motion
  cd runit_root do
    puts `ln -nsf #{runit_avail_app}`
  end

end

desc "Deploy to environment corresponding to current directory context"
task :deploy do
  # Try to figure out deploy_mode from directory context
  dir = File.basename Dir.pwd
  if dir=="#{$appname}-git"
    env=:production
  else
    m = %r!#{$appname}-(.*)-git!.match(dir)
    if m.nil?
      puts "ERROR: Could not determine environment from current directory context."
      puts "Expecting <appname>-<env>-git"
      exit 1
    end
    env = m[1]
  end
  deploy env.to_sym
end

desc "Deploy to test (on local machine)"
task :deploy_test do
  deploy :test
end

desc "Deploy to UAT (on local machine)"
task :deploy_uat do
  deploy :uat
end

desc "Deploy to production (on local machine)"
task :deploy_prod do
  deploy :production
end
