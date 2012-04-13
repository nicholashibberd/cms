module Cms
  class PhotosController < Cms::AdminController

    def index
      @photos = @group ? @group.photos : Photo.top_level
    end

    def new
      @photo = Photo.new
    end
    
    def show
    end

    def create
      photo = Photo.new(params[:photo])
      if photo.save
    		redirect_to photos_path(@group), :notice => "Successfully created photo"
      else
        raise photo.errors.inspect
        flash[:error] = "There was an error creating the photo"
        redirect_to photos_path(@group)
      end
    end

    def edit
      @photo = Photo.find(params[:id])
    end

    def update
      photo = Photo.find(params[:id])
      if photo.update_attributes(params[:photo])
    		redirect_to photos_path(@group), :notice => "Successfully updated photo"
      else
        flash[:error] = "There was an error updating the photo"
        render :action => 'edit'
      end
    end

    def destroy
      @photo = Photo.find(params[:id])
      @photo.destroy

      redirect_to photos_path(@group)
    end


  end
  
end