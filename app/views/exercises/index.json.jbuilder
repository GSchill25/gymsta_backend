json.exercises do |json|
  json.array! @exercises, partial: 'exercises/exercise', as: :exercise
end
