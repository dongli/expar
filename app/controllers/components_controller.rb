class ComponentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @components = Component.all
  end

  def new
    @component = Component.new
  end

  def create
    @component = Component.new(component_params)
    @component.created_by_user = current_user.id

    if @component.save
      redirect_to @component
    else
      render 'new'
    end
  end

  def show
    @component = Component.find(params[:id])
  end

  def edit
    @component = Component.find(params[:id])
  end

  def update
    @component = Component.find(params[:id])

    if @component.update(component_params)
      redirect_to @component
    else
      render 'edit'
    end
  end

  def destroy
    @component = Component.find(params[:id])
    @component.destroy

    redirect_to @component
  end

  private

  def component_params
    params.require(:component).permit(:title,
                                      :role,
                                      :versions,
                                      :resolutions,
                                      :contact,
                                      :email,
                                      :home_url,
                                      :created_by_user,
                                      :comment)
  end
end
