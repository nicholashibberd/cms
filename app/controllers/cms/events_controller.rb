module Cms
  class EventsController < Cms::AdminController  
  
    def index   
      @events = Event.all
    end

    def show
      @event = params[:series] ? EventSeries.find(params[:id]) : Event.find(params[:id])
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @event }
        format.js { render :json => @event.to_json }
      end
    end

    def new
      @event = Event.new
    end

    def edit
      @event = Event.find(params[:id])
    end

    def create
      if params[:event][:period] == "Does not repeat"      
        @event = Event.create(params[:event])
      else
        events = EventSeries.new(params[:event])
        @event_series = EventSeries.create(params[:event])
      end
      redirect_to events_path
    end

    def update
      @event = Event.find(params[:id])
      if @event.update_attributes(params[:event])
        redirect_to(events_path, :notice => 'Event was successfully updated.')
      else
        flash[:error] = "There was an error updating the event"
        render :action => "edit"
      end
    
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to events_path
    end
  
    def choose_layout
      request[:action] == 'show' ? default_layout : 'admin'  
    end
  
  end
end