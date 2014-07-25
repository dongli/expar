class ExperimentsController < ApplicationController
  before_filter except: [ :index, :show ] { authenticate_user(params) }
  respond_to :html, :json

  def index
    @experiments = Experiment.all
    respond_with @experiments
  end

  def new
    @experiment = Experiment.new
  end

  def create
    if params[:format] == 'json'
      # Replace model name (String) in params with model id and object.
      Model.all.each do |m|
        if params[:experiment][:model] == m.title
          params[:experiment][:model_id] = m.id
          params[:experiment][:model] = m
          break
        end
      end
    end
    @experiment = Experiment.new(experiment_params)
    @experiment.created_by_user = current_user.id
    @experiment.diags = []

    if @experiment.save
      if params[:format] == 'json'
        respond_with @experiment
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
    @experiment = Experiment.find(params[:id])
    respond_with @experiment
  end

  def edit
    @experiment = Experiment.find(params[:id])
  end

  def update
    @experiment = Experiment.find(params[:id])

    @experiment.component_versions = ''
    @experiment.component_resolutions = ''
    Model.all.find(@experiment.model_id).components.each do |c|
      version = params[:experiment][c.role+'_version']
      @experiment.component_versions += c.title+':'+version+', '
      resolution = params[:experiment][c.role+'_resolution']
      @experiment.component_resolutions += c.title+':'+resolution+', '
    end
    @experiment.component_versions.gsub!(/, $/, '')
    @experiment.component_resolutions.gsub!(/, $/, '')

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
                                       :model_id,
                                       :date,
                                       :contact,
                                       :email,
                                       :created_by_user,
                                       :atmosphere_version,
                                       :atmosphere_resolution,
                                       :land_version,
                                       :land_resolution,
                                       :component_versions,
                                       :component_resolutions,
                                       :comment)
  end
end
