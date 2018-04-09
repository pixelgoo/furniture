# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ title: 'Star Wars' }, { title: 'Lord of the Rings' }])
#   Character.create(title: 'Luke', movie: movies.first)

Role.create([
    { name: 'Customer' },
    { name: 'Manufacturer' },
    { name: 'Admin' }
])

if Rails.env.development? then
    admin = User.new :first_name => 'admin', :role_id => 2,
    :email => Rails.application.secrets.admin_login, 
    :password => Rails.application.secrets.admin_password, 
    :password_confirmation => Rails.application.secrets.admin_password
    admin.skip_confirmation!
    admin.save!
end


Tariff.create([
    { name: 'basic', price: '500' },
    { name: 'standard', price: '1200' },
    { name: 'premium', price: '2400' }
])

Furniture.create([
    { title: 'Кровати' },
    { title: 'Мягкая мебель' },
    { title: 'Деревянная мебель' },
    { title: 'Шкафы' },
    { title: 'Комоды и тумбы' },
    # TODO: write Categories for these Furnituries
    { title: 'Столы и стулья' },
    { title: 'Мебель для ванной' },
    { title: 'Мебель для гостиной' },
    { title: 'Мебель для прихожей' }
])

Category.create([
    { furniture_id: 1, id: 54, title: 'Односпальные кровати' },
    { furniture_id: 1, id: 55, title: 'Двуспальные кровати' },
    { furniture_id: 1, id: 58, title: 'Двухярусные кровати' },
    { furniture_id: 1, id: 251, title: 'Кровати для малышей' },
    { furniture_id: 1, id: 226, title: 'Деревянные кровати' },
    { furniture_id: 1, id: 252, title: 'Раскладные кровати' },
    { furniture_id: 1, id: 244, title: 'Кровати-машинки' },
    { furniture_id: 1, id: 261, title: 'Кровати-горки' },
    { furniture_id: 1, id: 279, title: 'Металлические кровати' },

    { furniture_id: 2, id: 75, title: 'Диваны' },
    { furniture_id: 2, id: 73, title: 'Мягкие уголки' },
    { furniture_id: 2, id: 74, title: 'Мягкие системы' },
    { furniture_id: 2, id: 270, title: 'Кресла и пуфы' },
    { furniture_id: 2, id: 203, title: 'Бескаркасная мебель' },

    { furniture_id: 3, id: 228, title: 'Деревянные столы' },
    { furniture_id: 3, id: 229, title: 'Деревянные стулья' },
    { furniture_id: 3, id: 227, title: 'Деревянные комоды и тумбы' },
    { furniture_id: 3, id: 234, title: 'Кухонные уголки из дерева' },

    { furniture_id: 4, id: 179, title: 'Шкафы обычные' },
    { furniture_id: 4, id: 72,  title: 'Шкафы-купе' },
    { furniture_id: 4, id: 180, title: 'Пеналы' },
    { furniture_id: 4, id: 200, title: 'Витрины' },
    { furniture_id: 4, id: 201, title: 'Стеллажи' },

    { furniture_id: 5, id: 16, title: 'Комоды' },
    { furniture_id: 5, id: 85, title: 'Тумбы' },
    { furniture_id: 5, id: 15, title: 'ТВ тумбы' },
    { furniture_id: 5, id: 185, title: 'Прикроватные тумбы' },
    { furniture_id: 5, id: 184, title: 'Обувные тумбы' }

])

Dir.glob("#{Rails.root}/lib/products/*.json").each do |file_path|
    next if file == '.' or file == '..'

    file = File.read(file_path)
    json_data = ActiveSupport::JSON.decode file

    category = Category.find(json_data['id'])

    json_data['products'].each do |product|
        cleaned_product = {}
    
        cleaned_product['product_id'] = product['id']
        cleaned_product['title'] = product['title']
        cleaned_product['factory'] = product['Производитель']
         
        unless product['Размеры'].nil? then
            cleaned_product['width'] = product['Размеры'][0]['width'] 
            cleaned_product['height'] = product['Размеры'][0]['height']
            cleaned_product['depth'] = product['Размеры'][0]['depth']
        end
        
        cleaned_product['style'] = product['Стиль']
        cleaned_product['facade'] = product['Фасад']
        cleaned_product['structure'] = product['Корпус']

        ['Тип шкафа-купе', 'Тип односпальной кровати'].each do |type|
            unless product[type].nil? then
                cleaned_product['product_type'] = product[type]
            end
        end

        database_product = Product.new(cleaned_product)
        database_product.category = category
        database_product.save!

        product['textiles'].each do |textile|
            database_product.textiles << Textile.new(name: textile)
        end
    end
end
