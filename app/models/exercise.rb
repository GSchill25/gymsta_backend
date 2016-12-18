class Exercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout

  validates :name, presence: true, allow_blank: false
  validates :etype, presence: true, allow_blank: false
end
