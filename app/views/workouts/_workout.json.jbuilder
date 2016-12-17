json.(workout, :title, :slug, :subtitle, :created_at, :updated_at, :tag_list)
json.author workout.user, partial: 'profiles/profile', as: :user
json.favorited signed_in? ? current_user.favorited?(workout) : false
json.favorites_count workout.favorites_count || 0
