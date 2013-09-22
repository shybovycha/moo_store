require 'faker'

# Create default users
print "Creating admin user..."
admin = User.create :email => 'admin@moo.store.com', :password => 'admin_passwd', :password_confirmation => 'admin_passwd'
print "Done\n"

print "Creating roles:\n"

print "* Administrator\n"
r = Role.create :title => 'Administrator'

r.permissions.create :model => 'User', :action => 'manage', :allowed => true
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => true
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => true

admin.roles << r

print "* Global Moderator\n"
r = Role.create :title => 'Global Moderator'

r.permissions.create :model => 'User', :action => 'manage', :allowed => true
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => true
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

print "* Product Manager\n"
r = Role.create :title => 'Product Manager'

r.permissions.create :model => 'User', :action => 'manage', :allowed => false
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => false
r.permissions.create :model => 'Order', :action => 'manage', :allowed => false
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

print "* Order Manager\n"
r = Role.create :title => 'Order Manager'

r.permissions.create :model => 'User', :action => 'manage', :allowed => false
r.permissions.create :model => 'Product', :action => 'manage', :allowed => false
r.permissions.create :model => 'Category', :action => 'manage', :allowed => false
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => false
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

print "* Unregistered User\n"
r = Role.create :title => 'Unregistered User'

r.permissions.create :model => 'ContactMessage', :action => 'create', :allowed => true
r.permissions.create :model => 'Product', :action => 'read', :allowed => true
r.permissions.create :model => 'Category', :action => 'read', :allowed => true

print "* Registered User\n"
r = Role.create :title => 'Registered User'

r.permissions.create :model => 'ContactMessage', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'read', :allowed => true

print "Done\n"

print "Creating default user..."
plain_user = User.create :email => 'user@moo_store.com', :password => 'user_passwd', :password_confirmation => 'user_passwd'

plain_user.roles << r
print "Done\n"

# Create some categories and products

print "Creating test category...\n"
c = Category.create :title => 'Test Category #1'

print "* Creating products...\n"

1.upto(30) do |i|
    price = ''

    length = rand(5) + 1
    length.times { price += rand(99).to_s }

    price = price.to_i / 10.0

    product = Product.create :title => "Product ##{ i }",
                             :description => Faker::Lorem.sentences(rand(10)).join,
                             :base_price => price

    c.products << product if rand(10) > 3
end

print "Done\n"