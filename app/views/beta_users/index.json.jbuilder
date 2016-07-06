json.array!(@beta_users) do |beta_user|
  json.extract! beta_user, :id, :email, :user_type
  json.url beta_user_url(beta_user, format: :json)
end
