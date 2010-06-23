class Todo < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :comments, :dependent => :destroy

  validates_presence_of :title
  validates_presence_of :due_time

end
