class PostsController < ApplicationController
	before_action :logged_in_user, only: [:new, :create]

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		@post.save
		redirect_to root_url
	end

	private

	def logged_in_user
		redirect_to login_path unless logged_in?
	end

	def post_params
		params.require(:post).permit(:title, :body)
	end
end
