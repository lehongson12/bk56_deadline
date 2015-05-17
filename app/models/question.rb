class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin
  has_many :answers, dependent: :destroy
end
