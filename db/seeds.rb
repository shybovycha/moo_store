# Create default users
admin = User.create :email => 'admin@moo_store.com', :password => 'admin_passwd', :password_confirmation => 'admin_passwd'

r = Role.create :title => 'Administrator'

r.permissions.create :model => 'User', :action => 'manage', :allowed => true
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => true
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => true

admin.roles << r

r = Role.create :title => 'Global Moderator'

r.permissions.create :model => 'User', :action => 'manage', :allowed => true
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => true
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

r = Role.create :title => 'Product Manager'

r.permissions.create :model => 'User', :action => 'manage', :allowed => false
r.permissions.create :model => 'Product', :action => 'manage', :allowed => true
r.permissions.create :model => 'Category', :action => 'manage', :allowed => true
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => false
r.permissions.create :model => 'Order', :action => 'manage', :allowed => false
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

r = Role.create :title => 'Order Manager'

r.permissions.create :model => 'User', :action => 'manage', :allowed => false
r.permissions.create :model => 'Product', :action => 'manage', :allowed => false
r.permissions.create :model => 'Category', :action => 'manage', :allowed => false
r.permissions.create :model => 'ContactMessage', :action => 'manage', :allowed => false
r.permissions.create :model => 'Order', :action => 'manage', :allowed => true
r.permissions.create :model => 'Role', :action => 'manage', :allowed => false

r = Role.create :title => 'Unregistered User'

r.permissions.create :model => 'ContactMessage', :action => 'create', :allowed => true
r.permissions.create :model => 'Product', :action => 'read', :allowed => true
r.permissions.create :model => 'Category', :action => 'read', :allowed => true

r = Role.create :title => 'Registered User'

r.permissions.create :model => 'ContactMessage', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'read', :allowed => true

plain_user = User.create :email => 'user@moo_store.com', :password => 'user_passwd', :password_confirmation => 'user_passwd'

plain_user.roles << r

# Create some categories and products

c = Category.create :title => 'Test Category #1'

p1 = Product.create :title => 'Product #1', :description => 'lorem ipsum ololo!', :base_price => 15.00
p2 = Product.create :title => 'Product #2', :description => 'lorem ipsum ololo!', :base_price => 99.80
p3 = Product.create :title => 'Product #3', :description => 'lorem ipsum ololo!', :base_price => 534.95
p4 = Product.create :title => 'Product #4', :description => 'lorem ipsum ololo!', :base_price => 16000.00
p5 = Product.create :title => 'Product #5', :description => 'lorem ipsum ololo!', :base_price => 42.30

c.products += [ p1, p3, p4 ]