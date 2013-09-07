class Image < ActiveRecord::Base
	has_attached_file :picture, :styles => { :thumbnail => "60x60#" }
end
