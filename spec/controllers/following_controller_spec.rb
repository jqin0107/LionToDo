require 'rails_helper'

describe FollowingController, type: :controller do
  activities = [
    {:event_name => 'Halloween Night', :location => "Butler", :creator_id => 1, :max_size => 10, :current_size =>3, :category => 'Entertainment', :date => '31-Oct-2022', :open_status => "Open"},
    {:event_name => 'Met Sunday', :location => "Central Park", :creator_id => 1, :max_size => 4, :current_size =>4, :category => 'Arts', :date => '30-Oct-2022', :open_status => "Open"},
    {:event_name => 'Study Monday', :location => "Uris", :creator_id => 2, :location => 'butler library', :max_size => 6, :current_size =>2, :category => 'Education', :date => '2-Nov-2022', :open_status => "Open"},
  ]

  users = [
    {:user_name => 'tester1', :first_name => 'tfn1', :last_name => 'tln1', :password => 'abcdefgh'},
    {:user_name => 'tester2', :first_name => 'tfn2', :last_name => 'tln2', :password => '12345678'},
  ]

  before do
    session[:user_id] = 1
    users.each do |user|
      User.new(user).save
    end
    activities.each do |activity|
      Activity.new(activity).save
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'follow a user successfully' do
    it 'should success' do
      post :create, :follower => 1, :followee => 2
      expect(response).to redirect_to(activities_path)
    end
  end

  describe 'unfollow a user successfully' do
    it 'should success' do
      post :create, :follower => 1, :followee => 2
      delete :destroy, :follower => 1, :followee => 2, :id => 1
      expect(response).to redirect_to(activities_path)
    end
  end
end
