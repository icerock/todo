class Comment < ActiveRecord::Base

  belongs_to :todo
  belongs_to :user

  
  validates_presence_of :comment_text

end
