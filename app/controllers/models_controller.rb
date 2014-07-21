class ModelsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @models = Model.all
  end

  def new
    @model = Model.new
  end

  def create
    @model = Model.new(model_params)
    @model.created_by_user = current_user.id

    if @model.save
      redirect_to @model
    else
      render 'new'
    end
  end

  def show
    @model = Model.find(params[:id])
  end

  def edit
    @model = Model.find(params[:id])
  end

  def update
    @model = Model.find(params[:id])

    if @model.update(model_params)
      redirect_to @model
    else
      render 'index'
    end
  end

  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    redirect_to @model
  end

  private

  def model_params
    params.require(:model).permit(:title,
                                  :contact,
                                  :email,
                                  :home_url,
                                  :created_by_user,
                                  :comment,
                                  { :component_ids => [] })
  end
end
