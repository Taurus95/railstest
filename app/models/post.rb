class Post < ApplicationRecord
  #mount_uploader allows you to load: photo (of the Posts model) linked to the ImageUploader
  mount_uploader :photo, ImageUploader

end
