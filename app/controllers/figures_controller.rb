class FiguresController < ApplicationController
  before_filter except: [ :index, :show ] { authenticate_user(params) }
  respond_to :html, :json

  def index
    @figures = Figure.all
  end

  def new
    @figure = Figure.new
  end

  def create
    if params[:format] == 'json'
      params[:diag_id]          = params[:diag_id].to_i
      params[:figure]           = {}
      params[:figure][:diag_id] = params[:diag_id]
      params[:figure][:title]   = params[:title]
      params[:figure][:file]    = params[:file]
      params[:figure][:comment] = params[:comment]
      params[:figure][:file].content_type = MIME::Types.type_for(params[:figure][:file].original_filename)[0].content_type
    end
    @figure = Figure.new(figure_params)
    @figure.created_by_user = current_user.id
    @diag = Diag.find(params[:diag_id])
    @diag.figures.push @figure

    if @figure.save
      if params[:format] == 'json'
        respond_with @figure
      else
        redirect_to diag_path(@diag)
      end
    else
      if params[:format] == 'json'
        respond_with @figure
      else
        render 'new'
      end
    end
  end

  def show
    @figure = Figure.find(params[:id])
  end

  def edit
    @figure = Figure.find(params[:id])
  end

  def update
    @figure = Figure.find(params[:id])

    if @figure.update(figure_params)
      redirect_to @figure
    else
      render 'edit'
    end
  end

  def destroy
    @figure = Figure.find(params[:id])
    @diag = Diag.find(@figure.diag_id)
    @figure.destroy

    redirect_to @diag
  end

  private

  def figure_params
    params.require(:figure).permit(:diag_id,
                                   :title,
                                   :file,
                                   :created_by_user,
                                   :comment)
  end
end
