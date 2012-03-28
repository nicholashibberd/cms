module Cms
  class PeopleController < Cms::AdminController  
    def index
      @people = @group ? @group.people : Person.top_level
    end

    def show
      @person = Person.find(params[:id])
    end

    def new
      @person = Person.new
    end

    def edit
      @person = Person.find(params[:id])
    end

    def create
      person = Person.new(params[:person])
      if person.save
        redirect_path = person.group ? group_path(person.group) : people_path
    		redirect_to people_path(@group), :notice => "Successfully created person"
      else
        flash[:error] = "There was an error creating the person"
        render :action => "new"
      end
    end

    def update
      person = Person.find(params[:id])

      if person.update_attributes(params[:person])
    		redirect_to people_path(@group), :notice => "Successfully updated person"
      else
        flash[:error] = "There was an error updating the person"
        render :action => "edit"
      end
    end

    def destroy
      @person = Person.find(params[:id])
      @person.destroy

      redirect_to people_path(@group)
    end
  end
end