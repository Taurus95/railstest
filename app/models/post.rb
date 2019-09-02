class Post < ApplicationRecord
    #adding atach file photo to the model
    has_one_attached :photo
    #adding the color 
    has_one :color
end
