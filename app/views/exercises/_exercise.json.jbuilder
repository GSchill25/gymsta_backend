json.(exercise, :id, :created_at, :updated_at, :type, :name, :sets, :reps, :description)
json.author exercise.user, partial: 'profiles/profile', as: :user
