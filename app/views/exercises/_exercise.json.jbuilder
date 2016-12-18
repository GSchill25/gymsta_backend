json.(exercise, :id, :created_at, :updated_at, :etype, :name, :sets, :reps, :description)
json.author exercise.user, partial: 'profiles/profile', as: :user
