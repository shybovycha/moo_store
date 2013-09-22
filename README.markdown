# MooShop

## Brief overview

This is a very simple shop sample, inspired by Magento architecture, Rails-based and Moo-powered.
There are some architecture notes, attached below.

## Models

* User
* Product
* ShoppingCart
* Category
* Order
* OrderItem
* Image
* ContactMessage
* Permission
* Role

### User model

    email, password
    first name, last name, gender, birthday, address, phone
    
    has_many :orders
    has_one :shopping_cart
    has_many_and_belongs_to :role

### Permission model

    action, model

    has_many_and_belongs_to :role

### Role model

    title

    has_many_and_belongs_to :permissions
    has_many_and_belongs_to :user
    
### Product model

    title, description, base_price

    has_many :images
    belongs_to :shopping_cart
    has_many_and_belongs_to :category

### ShoppingCart model
    
    belongs_to :user
    has_many :products

### Category model

    title

    has_many_and_belongs_to :products

### Order model

    address, payment_method, status

    belongs_to :user
    has_many :order_items

### OrderItem model

    title, price

    belongs_to :order

### Image model

    has_attachment :picture

    belongs_to :product

### ContactMessage model

    author_name, author_email, message, status

## Controllers

* pages
* users
* products [Resource]
* categories [Resource]
* orders [Resource]
* backoffice

## Notes

### CanCan fix for Rails4

This one prevents exceptions related to Strong Attributes, presented in Rails4, appearing.

    # application_controller.rb
    before_filter do
        resource = controller_name.singularize.to_sym
        method = "#{resource}_params"

        params[resource] &&= send(method) if respond_to?(method, true)
    end

### Тех. задание

 1. Разработать веб­сайт в виде интернет­магазина, который позволяет реализовать разнообразные товары через сеть Интернет.
 2. Интернет­магазин должен иметь клиентскую часть (frontend) и админ­панель (backoffice)
 3. Админ­панель должна быть закрыта от доступа любыми пользователями, кроме
 пользователей с привилегией администратора магазина.
 4. Админ­панель должна обеспечивать CRUD ­ операции (Create, Read, Update, Delete) для таких
 сущностей как:
   * товары
   * категории товаров
   * пользователи магазина
 5. Админ­панель должна обеспечивать RUD ­ операции (Read, Update, Delete) для таких таких
 сущностей, как:
   * заказы пользователей
   * запросы через форму контактов
 6. Клиентская часть интернет­магазина должна иметь следующие страницы или типы страниц:
   * [x] стартовая страница*
   * [x] страница регистрации новых пользователей *
   * [x] страница профиля пользователя
   * [x] страница для восстановления забытого пароля *
   * [o] страница c формой контактов *
   * [o] страница со списком категорий товаров магазина
   * [x] страница со списком продуктов в категории магазина, с пейджингом
   * [x] страница с подробностями продукта
   * [x] страница­корзина, отображающая список выбранных в данной сессии товаров *
   * [x] страница оплаты заказа
   * [o] страница истории оплаченных заказов пользователя, с пейджингом

 Страницы, помеченные *, доступны для всех пользователей, остальные страницы доступны
 только аутентифицированным пользователям.
 7. При реализации задания обязательно использовать ООП (объектно­ориентированное
 программирование) для таких сущностей, как пользователи, категории продуктов, продукты,
 заказы, корзина и т.д.
 8. Организовать импорт категорий продуктов и продуктов в магазин из XML­файла, наличие
 которого проверяется в конфигурируемой папке. В структуру XML внести те поля, которые
 присутствуют в соответствующих таблицах в базе данных.
 9. Организовать экспорт заказов магазина в XML­файл, записываемый в конфигурируемую папку.
 Каждый новый экспорт должен содержать только новые заказы (оплаченные со времени
 последнего экспорта). Результирующий XML­файл должен содержать полную информацию о
 заказе (продукты, их количество, общую цену, имя пользователя, оплатившего за