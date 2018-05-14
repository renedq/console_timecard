class Vendor < ActiveRecord::Base
  mount_uploader :image, VendorImageUploader

  has_many :menus

  def self.dropdown
      all.map { |v| [ v.name, v.id ] }
  end
end
