admin_pw = "12345678"
User.destroy_all
User.create!(email: 'admin@ex.ru', password: admin_pw, password_confirmation: admin_pw)

Page.destroy_all
Menu.destroy_all
h = Menu.create(name: 'Главное', text_slug: 'main').id
p = Page.create!(name: 'Админка', fullpath: '/admin', menu_ids: [h])
p = Page.create!(name: 'Проекты', content: 'проекты', fullpath: '/projects', menu_ids: [h])
Page.create!(name: 'Прайс лист', fullpath: '/price', menu_ids: [h])
Page.create!(name: 'Галерея', fullpath: '/galleries', menu_ids: [h])
c = Page.create!(name: 'О компании', fullpath: '/company', menu_ids: [h], content: 'О Компании')
Page.create!(name: 'Новости', fullpath: '/news', menu_ids: [h])
Page.create!(name: 'Контакты', fullpath: '/contacts', menu_ids: [h], content: 'Текст стр контакты')

