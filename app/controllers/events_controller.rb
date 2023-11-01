class EventsController < ApplicationController
  #before_action :user_authenticate
  before_action :force_index_redirect, only: [:index]
  #helper_method :get_organizor_name, :can_modify, :participated

      def show
        id = params[:id] 
        @event = Event.find(id)
      end

      def index
        @events = Event.all
        # for e in @events do
        #   if e[:date] < Date.today
        #     e.update(open_status: 'Close')
        #   end
        #end

        #@event_status = params[:event_status]
        @all_tags = Event.all_tags
        @events_with_tag = Event.with_tags(tag_list, sort_by)
        # if @event_status == 'Open'
        #   @events = open_events(@events_with_tag)
        # else
        #   @events = @events_with_tag
        # end



        @tags_hash = tags_hash
        @sort_by = sort_by


        session['tags'] = tag_list
        session['sort_by'] = @sort_by
      end


    
    
      def new
        # default: render 'new' template
      end
    
      def create
        @event = Event.create!(event_params)
        flash[:notice] = "#{@event.title} was successfully created."
        # begin
        #   @event = Event.create!(event_params)
        #   #@event.update(creator_id: session[:user_id])
        # rescue => exception
        #   flash[:notice] = "Some fields are empty, event cannot be created."
        # else
        #   flash[:notice] = "#{@event.event_name} was successfully created."

        # end
        # ActivityUserRelation.create!(session[:user_id], @event.id)
        
        redirect_to events_path
      end
    
      def edit
        @event = Event.find params[:id]
        # if !can_modify(@event)
        #   flash[:warning] = "You aren't authorized to modify this event!"
        #   redirect_to event_path(@event)
        # end
      end
    
      def update
        @event = Event.find params[:id]
        @event.update_attributes!(event_params)
        flash[:notice] = "#{@event.title} was successfully updated."
        # if can_modify(@event)
        #   begin 
        #     @event.update_attributes!(event_params)
        #   rescue => exception
        #     flash[:notice] = "Some fields are empty, event cannot be updated."
        #   else
        #     flash[:notice] = "#{@event.event_name} was successfully updated."
            
        #   end
        # end
        redirect_to event_path(@event)
      end
    
      def destroy
        @event = Event.find(params[:id])
        @event.destroy
        flash[:notice] = "Event '#{@event.event_name}' deleted."
        # if can_modify(@event)
        #   @event.destroy
        #   flash[:notice] = "Event '#{@event.event_name}' deleted."
        # end
        redirect_to events_path
      end
    
      private
      # Making "internal" methods private is not required, but is a common practice.
      # This helps make clear which methods respond to requests, and which ones do not.
      def event_params
        params.require(:event).permit(:title, :location, :date, :tags)
      end 

      # private
      # def get_organizor_name(event)
      #   creator = User.find(event.creator_id)
      #   organizer = creator.first_name + " " + creator.last_name
      #   return organizer
      # end









      private
      def can_modify(event)
        # if event.creator_id == session[:user_id]
        #   return true
        # end
        # return false
        return true
      end

      private
      def participated(event)
        return !ActivityUserRelation.where(user_id: session[:user_id], event_id: event.id).empty?
      end

      def force_index_redirect
        if !params.key?(:tags) || !params.key?(:sort_by)
          flash.keep
          url = events_path(sort_by: sort_by, tags: tags_hash)
          redirect_to url
        end
      end

      def tag_list
        params[:tags]&.keys || session[:tags] || Event.all_tags
      end


      def tags_hash
        Hash[tag_list.collect { |item| [item, "1"] }]
      end

      def sort_by
        params[:sort_by] || session[:sort_by] || 'id'
      end

      # def open_events(events)
      #   events.where(open_status: 'Open')
      # end



      # def user_authenticate
      #   if session[:user_id] == nil
      #     redirect_to new_session_path
      #     return
      #   end
      # end

end
