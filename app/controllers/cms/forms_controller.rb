module Cms
  class FormsController < Cms::AdminController  
    def index
      @forms = Form.all
    end

    def show
      @form = Form.find(params[:id])
    end
  
    def new
      @form = Form.new
      2.times { @form.form_fields.build }
    end
  
    def edit
      @form = Form.find(params[:id])
    end

    def create
      @form = Form.new(params[:form])
      if @form.save
        redirect_to forms_path, :notice => "Successfully created form"
      else
        flash[:error] = "There was an error creating the form"
        render :action => 'new'
      end
    end
  
    def update
      @form = Form.find(params[:id])
      if @form.update_attributes(params[:form])
        redirect_to forms_path, :notice => "Successfully created form"
      else
        flash[:error] = "There was an error updating the form"
        render :action => 'new'
      end
    end

    def destroy
      @form = Form.find(params[:id])
      institution = @form.institution
      @form.destroy
      redirect_to forms_path(institution)
    end
  
    def create_form_data
      raise params.inspect
    end
  end
end