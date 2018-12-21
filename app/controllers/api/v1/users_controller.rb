class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

    def create
     id = params[:name].delete(' ')
     client = Stream::Client.new('', '', :location => 'us-east')
     @user =  client.users.add( id, :data => {:name => params[:name], :occupation => params[:occupation], :gender => params[:gender]},)
     render json: { user: @user, status: 201, success: true } 
    end

    def index
      client = Stream::Client.new('', '', :location => 'us-east')
      user =  client.users.get("Arpitha")
      render json: { user: user, status: 201, success: true } 
    end

  def flat_feeds
    client = Stream::Client.new('', '', :location => 'us-east')
    user_feed = client.feed('user', 'Arpitha')
    activity_data = {:actor => 'Arpitha', :verb => 'tweet', :object => 1, :tweet => 'Hello Sunil'}
    activity_response = user_feed.add_activity(activity_data)
    render json: { activity_data: activity_response, status: 201, success: true }
  end

  def get_activities
    client = Stream::Client.new('', '', :location => 'us-east')
    user_feed = client.feed('user', 'Arpitha')
    result = user_feed.get(:limit=>5)
    render json: { activities: result, status: 201, success: true }
  end
 
end