json.workouts do |json|
  json.array! @workouts, partial: 'workouts/workout', as: :workout
end

json.workouts_count @workouts_count
