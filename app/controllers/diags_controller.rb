class DiagsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @diags = Diag.all
  end

  def new
    @diag = Diag.new
  end

  def create
    @diag = Diag.new(diag_params)
    @diag.created_by_user = current_user.id
    @diag.figures = []
    @experiment = Experiment.find(params[:experiment_id])
    @experiment.diags.push @diag

    if @diag.save
      redirect_to @experiment
    else
      render 'new'
    end
  end

  def show
    @diag = Diag.find(params[:id])
  end

  def edit
    @diag = Diag.find(params[:id])
  end

  def update
    @diag = Diag.find(params[:id])

    if @diag.update(diag_params)
      redirect_to @diag
    else
      render 'edit'
    end
  end

  def destroy
    @diag = Diag.find(params[:id])
    @experiment = Experiment.find(params[:experiment_id])
    @diag.destroy

    redirect_to @experiment
  end

  private

  def diag_params
    params.require(:diag).permit(:experiment_id,
                                 :category,
                                 :contact,
                                 :email,
                                 :created_by_user,
                                 :comment)
  end
end
