class ExperimentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @experiments = Experiment.all
  end

  def new
    @experiment = Experiment.new
  end

  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.created_by_user = current_user.id
    @experiment.diags = []

    if @experiment.save
      redirect_to @experiment
    else
      render 'new'
    end
  end

  def show
    @experiment = Experiment.find(params[:id])
  end

  def edit
    @experiment = Experiment.find(params[:id])
  end

  def update
    @experiment = Experiment.find(params[:id])

    if @experiment.update(experiment_params)
      redirect_to @experiment
    else
      render 'edit'
    end
  end

  def destroy
    @experiment = Experiment.find(params[:id])
    @experiment.destroy

    redirect_to @experiment
  end

  private

  def experiment_params
    params.require(:experiment).permit(:title,
                                       :model,
                                       :date,
                                       :author,
                                       :email,
                                       :created_by_user,
                                       :comment)
  end
end
