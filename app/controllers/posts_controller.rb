class PostsController < ApplicationController
	before_action :logged_in_user, only: :index

	def index
	end

	def new
		@post = Post.new
	end

	def create
	end

	private

	def logged_in_user
		redirect_to login_path unless logged_in?
	end
end
