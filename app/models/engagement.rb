class Engagement < ActiveRecord::Base
  mount_uploader :post_file, AvatarUploader
end
