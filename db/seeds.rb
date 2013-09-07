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

r = Role.create :title => 'Registered User'

r.permissions.create :model => 'ContactMessage', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'create', :allowed => true
r.permissions.create :model => 'Order', :action => 'read', :allowed => true
