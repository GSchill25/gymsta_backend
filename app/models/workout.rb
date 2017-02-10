class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :exercises, dependent: :destroy

  scope :authored_by, ->(username) { where(user: User.where(username: username)) }
  scope :favorited_by, -> (username) { joins(:favorites).where(favorites: { user: User.where(username: username) }) }

  acts_as_taggable

  validates :title, presence: true, allow_blank: false
  validates :subtitle, presence: true, allow_blank: true
  validates :slug, uniqueness: true, exclusion: { in: ['feed'] }

  has_many :workouts, dependent: :destroy

  before_validation do
    self.slug ||= "#{title.to_s.parameterize}-#{rand(36**6).to_s(36)}"
  end

  def self.count_exercise_types(exercises) #eTypes should probably go into a config file
    eTypeCounter = [{ "name": "Warmup", "value": 0 },
                    { "name": "Stretch", "value": 0 },
                    { "name": "Run", "value": 0 },
                    { "name": "Lift", "value": 0 },
                    { "name": "Other", "value": 0 }
                   ]
    exercises.each do |e|
      eTypeCounter.each do |et|
        if(et[:name] == e.etype)
          et[:value] += 1
        end
      end
    end
    eTypeCounter
  end

  def exercise_breakdown
    eTypeCounter = [{ "name": "Warmup", "value": 0 },
                    { "name": "Stretch", "value": 0 },
                    { "name": "Run", "value": 0 },
                    { "name": "Lift", "value": 0 },
                    { "name": "Other", "value": 0 }
                   ]
    self.exercises.each do |e|
      eTypeCounter.each do |et|
        if(et[:name] == e.etype)
          et[:value] += 1
        end
      end
    end
    eTypeCounter
  end
end
