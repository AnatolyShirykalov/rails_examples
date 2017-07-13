admin_pw = "12345678"

puts "drop old data"
[User, Page, Menu, Car, Recipe, Property].each{|m| m.destroy_all}
User.create!(email: 'admin@ex.ru', password: admin_pw, password_confirmation: admin_pw)

h = Menu.create(name: 'Главное', text_slug: 'main').id

Page.create!(name: 'Админка', fullpath: '/admin', menu_ids: [h])
Page.create!(name: 'Автомобили', fullpath: '/cars', menu_ids: [h])
Page.create!(name: 'Рецепты', fullpath: '/recipes', menu_ids: [h])

def create_prop name, count, creator
  ret = Property.create! name: name
  count.times { ret.values.find_or_create_by! name: eval(creator) }
  ret
end

def assign_props model_const, props, samples
  model_const.find_each do |model|
    props.each do |prop|
      prop.values.to_a.sample(eval(samples)).each do |value|
        model.values.push value
      end
    end
    model.save!
  end
end

puts "create cars and recipes"
100.times do
  car = Car.find_or_create_by! name: FFaker::Vehicle.make + ' ' +FFaker::Vehicle.model
  car.price = (1 + rand(100)) * 100000
  car.save!
  Recipe.find_or_create_by! name: FFaker::Food.meat
end

puts "create poperties for cars"
props = %w[base_color drivetrain engine_cylinders fuel_type interior_upholstery transmission].map do |key|
  create_prop key, 6, "FFaker::Vehicle.#{key}"
end

assign_props Car, props, "1"

puts "create properties for recipes"
props = []
props.push create_prop "ingredient", 6, "FFaker::Food.ingredient"
props.push create_prop 'country',    6, "FFaker::Address.country"
props.push create_prop 'author',     6, "FFaker::NameRU.name"

assign_props Recipe, props, "rand(4) + 1"


