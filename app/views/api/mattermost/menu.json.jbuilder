if @menu != nil
    json.id @menu.id
    json.vendor @menu.vendor.name
    json.image @menu.vendor.image.url
    json.menu_date @menu.menu_date 
    json.menu_type @menu.menu_type 
    json.details @menu.details 
end
