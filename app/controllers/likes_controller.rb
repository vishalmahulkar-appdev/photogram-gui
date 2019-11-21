class LikesController < ApplicationController
  def index
    likes = Like.all.order({ :created_at => :asc })

    render({ :json => likes.as_json })
  end

  def show
    the_id = params.fetch(:the_photo_id)
    like = Like.where({ :id => the_id }).at(0)

    render({ :json => like.as_json })
  end

  def create
    like = Like.new
    like.fan_id = params.fetch(:input_user_id, nil)
    like.photo_id = params.fetch(:input_photo_id, nil)
    like.save
    
    redirect_to("/photos/"+like.photo_id.to_s)
  end

  def update
    the_id = params.fetch(:the_photo_id)
    like = Like.where({ :id => the_id }).at(0)
    like.fan_id = params.fetch(:input_fan_id, nil)
    like.photo_id = params.fetch(:input_photo_id, nil)
    like.save
    
    render({ :json => like.as_json })
  end
  
  def destroy
    like = Like.where({:id => params.fetch(:the_like_id)}).at(0).destroy

    render({ :json => like.as_json })
  end
end
