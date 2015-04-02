module SessionsHelper

	def login(user)
		session[:user_id] = user.id 
	end

	def logged_in?
		!current_user.nil?
	end

	def logout
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	def forget(user)
		user.forget
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id 
		cookies.permanent[:remember_tpken] = user.remember_token
	end

	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
		elsif cookies.signed[:user_id]
			user = User.find_by(id: cookies.signed[:user_id])
			if user && user.authenticated?(cookies[:remember_token])
				login user
				@current_user = user
			end
		end
	end	
end
