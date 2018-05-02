# frozen_string_literal: true

def log_in(user)
  session[:user_id] = user.id
end
