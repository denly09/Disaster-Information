class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]
  before_action :set_categories
  require 'csv'

  def index
    @posts = Post.includes(:user, :categories, :region, :province, :city_municipality, :barangay).order(comments_count: :desc).all
    @hot_posts = Post.order(comments_count: :desc).limit(3).select{ |post| post.comments_count >= 1 }
    respond_to do |format|
      format.html
      format.json { render  json: @posts, each_serializer: PostSerializer }
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << [User.human_attribute_name(:email), Post.human_attribute_name(:id), Post.human_attribute_name(:title), Post.human_attribute_name(:content), Post.human_attribute_name(:categories), Post.human_attribute_name(:created_at)]
          @posts.each do |p|
            csv << [p.user.email, p.id, p.title, p.content, p.categories.pluck(:name).join(','), p.created_at]
          end
        end
        render plain: csv_string
      }
      format.xml { render xml: @posts.as_json }
    end
  end

  def new
    @post = Post.new
    @random = sprintf "%04d", rand(2 - 9999), unique: true
  end

  def short_url
    @post = Post.find_by(unique_num: params[:unique_num])
    redirect_to post_path(@post)

  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if Rails.env.development?
      @post.ip_address= Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    else
      @post.ip_address= request.remote_ip
    end
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @post, serializer: PostSerializer }
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.comments_count >= 1
      flash[:notice] = "The post with comments can't be deleted."
    else @post.destroy
    end
    redirect_to posts_path
  end

  private


  def set_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:title, :content, :address, :unique_num, :image, :address_region_id,
                                 :address_province_id, :address_city_municipality_id, :address_barangays_id, category_ids: [])
  end

  def validate_post_owner
    unless @post.user == current_user
      flash[:notice] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end

  def set_categories
    @categories = Category.all
  end
end
