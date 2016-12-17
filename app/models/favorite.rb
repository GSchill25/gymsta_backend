class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout, counter_cache: true
end
