class Word < ActiveRecord::Base
  has_many :results
  has_many :answers

  belongs_to :category
end
