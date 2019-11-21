class UsersController < ApplicationController
  def index
    @users = User.all.order({ :username => :asc })
  
    respond_to do |format|
      format.html do
        render( { :template => "/user_templates/user_list.html.erb"})
      end

      format.json do
        render({ :json => @users.as_json })
      end
    end
    
  end
  
  def show
    the_username = params.fetch(:the_username)
    @user = User.where({ :username => the_username }).at(0)
  
    respond_to do |format|
      format.html do
        render( { :template => "/user_templates/user_details.html.erb"})
      end

      format.json do
        render({ :json => @user.as_json })
      end
    end

    
  end
  
  def create
    @user = User.new
  
    @user.username = params.fetch(:input_username, nil)
    @user.private = params.fetch(:input_private, nil)
    @user.likes_count = params.fetch(:input_likes_count, 0)
    @user.comments_count = params.fetch(:input_comments_count, 0)
    
    @user.save
    
    redirect_to("/users/"+@user.username)
  end
  
  def update
    the_id = params.fetch(:the_user_id)
    user = User.where({ :id => the_id }).at(0)
  
  
    user.username = params.fetch(:input_username, user.username)
    user.private = params.fetch(:input_private, nil)
    user.likes_count = params.fetch(:input_likes_count, user.likes_count)
    user.comments_count = params.fetch(:input_comments_count, user.comments_count)
    
    user.save
  
    redirect_to("/users/"+user.username)
  
  end
  
  def destroy
    username = params.fetch(:the_username)
    user = User.where({ :username => username }).at(0)
  
    user.destroy
  
    render({ :json => user.as_json })
  end
  
  def liked_photos
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)

    respond_to do |format|
      format.html do
        render( { :template => "/user_templates/liked_photos.html.erb"})
      end

      format.json do
        render({ :json => @user.liked_photos.as_json })
      end
    end
    
  end
  
  def own_photos
    username = params.fetch(:the_username)
    user = User.where({ :username => username }).at(0)
  
    render({ :json => user.own_photos.as_json })
  end
  
  def feed
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)
    
    render({ :json => @user.feed.as_json })
  
  end
  
  def discover
    username = params.fetch(:the_username)
    @user = User.where({ :username => username }).at(0)
  
    render({ :json => @user.discover.as_json })
  
  end
  
end
