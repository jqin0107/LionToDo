require 'rails_helper'

describe ToDoListController, type: :controller do 
    activities = [
        {:event_name => 'Midterm Study', :location => 'Butler', :creater_id => 1, :date => '25-Oct-2023'},
        {:event_name => 'Halloween', :location => 'Central Park', :creater_id => 2, :date => '31-Oct-2023'},
    ]

    users = [
        {:user_name => 'test1', :first_name => 'first_name_1', :last_name => "last_name_1", :password => 'abcd'},
        {:user_name => 'test2', :first_name => 'first_name_2', :last_name => "last_name_2", :password => '1234'},
    ]

    relations = [
        {:user_id => 1, :activity_id => 1}
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

    describe 'create new event successfully' do
        if 'should success' do 
            post :create, :activity => {:event_name => 'Korean Food', :location => 'KTown', :date => '27-Oct-2023'}
            expect(response).to redirect_to(activities_path)
        end
    end

    describe 'delete a private event successfully' do 
        it 'should success' do
            delete :destroy, :id => Activity.find_by(event_name: 'Midterm Study').id
            expect(response).to redirect_to(activities_path)
        end
    end

    describe 'delete a public event successfully' do
        it 'should success' do
            delete :destroy, :id => Activity.find_by(event_name: 'Halloween').id
            expect(response).to redirect_to(activities_path)
        end
    end

    describe 'show the detail of an event successfully' do 
        it 'should success' do
            get :show, :id => Activity.find_by(event_name: 'Halloween').id
            expect(response).to have_http_status(:success)
            expect(assigns(:activity)).to eq(Activity.find_by(event_name: 'Halloween'))
        end
    end

    describe 'update date' do
        it 'should update date' do
            get :edit, :id => Activity.find_by(event_name: 'Midterm Study').id
            put :update, :id => Activity.find_by(event_name: 'Midterm Study').id, :activity => {:date => '26-Oct-2023'}
            expect(assigns(:activity).date).to eq('26-Oct-2023')
        end
    end

end