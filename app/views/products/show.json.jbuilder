json.product do
    json.id @item[:id]
    json.name @item[:name]
    json.user do
        json.id @user[:id]
        json.name @user[:name]
    end
end