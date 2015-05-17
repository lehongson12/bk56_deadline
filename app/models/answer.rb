class Answer < ActiveRecord::Base
  belongs_to :admin
  belongs_to :question
end
