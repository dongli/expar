class FiguresController < ApplicationController
  def index
    @figures = Figure.all
  end

  def new
    @figure = Figure.new
  end

  def create
    @figure = Figure.new(figure_params)
    @figure.created_by_user = current_user.id
    @diag = Diag.find(params[:diag_id])
    @diag.figures.push @figure

    if @figure.save
      redirect_to diag_path(@diag)
    else
      render 'new'
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
    @diag = Diag.find(params[:diag_id])
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
