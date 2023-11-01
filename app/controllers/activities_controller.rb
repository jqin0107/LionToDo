class ActivitiesController < ApplicationController
  before_action :user_authenticate
  before_action :force_index_redirect, only: [:index]
  helper_method :get_organizor_name, :can_modify, :participated

      def show
        id = params[:id] 
        @activity = Activity.find(id)
      end

      def index
        @activities = Activity.all
        for a in @activities do
          if a[:date] < Date.today
            a.update(open_status: 'Close')
          end
        end

        @event_status = params[:event_status]
        @all_categories = Activity.all_categories
        @activities_with_category = Activity.with_categories(category_list, sort_by)
        if @event_status == 'Open'
          @activities = open_activities(@activities_with_category)
        else
          @activities = @activities_with_category
        end



        @categories_hash = categories_hash
        @sort_by = sort_by


        session['categories'] = category_list
        session['sort_by'] = @sort_by
      end


    
    
      def new
        # default: render 'new' template
      end
    
      def create
        begin
          @activity = Activity.create!(activity_params)
          @activity.update(creator_id: session[:user_id])
        rescue => exception
          flash[:notice] = "Some fields are empty, event cannot be created."
        else
          flash[:notice] = "#{@activity.event_name} was successfully created."

        end
        #ActivityUserRelation.create!(session[:user_id], @activity.id)
        
        redirect_to activities_path
      end
    
      def edit
        @activity = Activity.find params[:id]
        if !can_modify(@activity)
          flash[:warning] = "You aren't authorized to modify this event!"
          redirect_to activity_path(@activity)
        end
      end
    
      def update
        @activity = Activity.find params[:id]
        if can_modify(@activity)
          begin 
            @activity.update_attributes!(activity_params)
          rescue => exception
            flash[:notice] = "Some fields are empty, event cannot be updated."
          else
            flash[:notice] = "#{@activity.event_name} was successfully updated."
            
          end
        end
        redirect_to activity_path(@activity)
      end
    
      def destroy
        @activity = Activity.find(params[:id])
        if can_modify(@activity)
          @activity.destroy
          flash[:notice] = "Activity '#{@activity.event_name}' deleted."
        end
        redirect_to activities_path
      end
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      def activity_params
        params.require(:activity).permit(:event_name, :location, :description, :date, :max_size, :current_size, :creator_id, :category, :open_status)
      end 

      private
      def get_organizor_name(activity)
        creator = User.find(activity.creator_id)
        organizer = creator.first_name + " " + creator.last_name
        return organizer
      end









      private
      def can_modify(activity)
        if activity.creator_id == session[:user_id]
          return true
        end
        return false
      end

      private
      def participated(activity)
        return !ActivityUserRelation.where(user_id: session[:user_id], activity_id: activity.id).empty?
      end

      def force_index_redirect
        if !params.key?(:categories) || !params.key?(:sort_by)
          flash.keep
          url = activities_path(sort_by: sort_by, categories: categories_hash)
          redirect_to url
        end
      end

      def category_list
        params[:categories]&.keys || session[:categories] || Activity.all_categories
      end


      def categories_hash
        Hash[category_list.collect { |item| [item, "1"] }]
      end

      def sort_by
        params[:sort_by] || session[:sort_by] || 'id'
      end

      def open_activities(activities)
        activities.where(open_status: 'Open')
      end



      def user_authenticate
        if session[:user_id] == nil
          redirect_to new_session_path
          return
        end
      end

end
