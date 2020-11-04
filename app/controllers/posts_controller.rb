# frozen_string_literal: true

class PostsController < ApplicationController

  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show search]
  before_action :authorize!, only: %i[update edit destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts ||= Post.all.paginate(page: params[:page])
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  # SEARCH /posts/search?keyword
  def search
    # @posts = Post.all.paginate(page: params[:page])
    @posts = PostOperation::SearchPost.execute(search_params)

    render :index
  end

  private

  def set_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :banner, :picture)
  end

  def search_params
    params.permit(:keyword, :page).merge!(user: current_user)
  end

  def authorize!
    raise Authz::UnauthorizedError if !current_user.admin && current_user.id != @post.user_id
  end

end
