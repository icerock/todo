class Project < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :project_notes

  has_and_belongs_to_many :users
  has_and_belongs_to_many :tasks

end
