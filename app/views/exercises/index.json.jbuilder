json.exercises do |json|
  json.array! @exercises, partial: 'exercises/exercise', as: :exercise
end

json.exercise_count do |json|
  json.array!(@exercise_count) do |eType|
  	json.name eType[:name]
  	json.value eType[:value]
  end
end