class Task < ActiveRecord::Base

  has_and_belongs_to_many :projects

  validates_presence_of :task_name
  

end
