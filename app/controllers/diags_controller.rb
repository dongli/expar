class DiagsController < ApplicationController
  before_filter except: [ :index, :show ] { authenticate_user(params) }
  respond_to :html, :json

  def index
    @diags = Diag.all
  end

  def new
    @diag = Diag.new
  end

  def create
    if params[:format] == 'json'
      # Replace category name with category id.
      Diag.categories.each do |category_name, category_id|
        if params[:diag][:category].downcase == category_name
          params[:diag][:category] = category_id
          break
        end
      end
    end
    @diag = Diag.new(diag_params)
    @diag.created_by_user = current_user.id
    @diag.figures = []
    @experiment = Experiment.find(params[:experiment_id])
    @experiment.diags.push @diag

    if @diag.save
      if params[:format] == 'json'
        respond_with @diag
      else
        redirect_to @experiment
      end
    else
      if params[:format] == 'json'
      else
        render 'new'
      end
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
