class Note < ActiveRecord::Base
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'

end
