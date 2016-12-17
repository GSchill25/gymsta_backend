json.workout do |json|
  json.partial! 'workouts/workout', workout: @workout
end
