class PostsController < ApplicationController
    before_action :set_post, only: [:edit, :update, :show, :destroy]
    def index
        @posts = Post.all.order("created_at DESC")
    end

    def new 
        @post = Post.new
    end

    def create
        @post = current_user.posts.new(post_params)
        if @post.save 
            redirect_to(root_path, :notice => 'Post was successfully created')
        else
            flash.now[:alert] = "can't be blank"
            render :new
        end
    end

    def edit 
    end

    def update
        if @post.update(post_params) 
          flash[:success] = "Post is successfully updated"
          redirect_to root_path
        else
          render :edit
        end
    end

    def show
    end

    def destroy 
        @post.destroy 
        flash[:danger] = "Post was successfully deleted"
        redirect_to posts_path
    end
        
        private  
        
    def post_params
        params.require(:post).permit(:content)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end