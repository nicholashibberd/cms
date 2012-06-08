module Cms
  class DocumentsController < Cms::AdminController  

    def new
      @document = Document.new
    end
  
    def edit
      @document = Document.find(params[:id])
    end
  
    def index
      @documents = @group ? @group.documents : Document.top_level
    end
  
    def show
      @document = Document.find(params[:id])
      redirect_to @document.pdf.url(:original)
    end
  
    def create
      document = Document.new(params[:document])
      if document.save
    		redirect_to documents_path(@group), :notice => "Successfully created document"
      else
        flash[:error] = "There was an error creating the document"
        render :action => 'new'
      end
    end
    
    def destroy
      document = Document.find(params[:id])
      document.destroy
      redirect_to documents_path(@group)
    end
  
  end
end