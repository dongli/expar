class FiguresController < ApplicationController
    def index
        @figures = Figure.all
    end

    def new
        @figure = Figure.new
    end

    def create
        @figure = Figure.new(figure_params)
        @experiment = Experiment.find(params[:experiment_id])
        @experiment.figures.push @figure

        if @figure.save
            redirect_to @experiment
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
        @experiment = Experiment.find(params[:experiment_id])

        if @figure.update(figure_params)
            redirect_to @experiment
        else
            render 'edit'
        end
    end

    def destroy
        @figure = Figure.find(params[:id])
        @experiment = Experiment.find(params[:experiment_id])
        @figure.destroy

        redirect_to @experiment
    end

    private

    def figure_params
        params.require(:figure).permit(:experiment_id, :title, :file, :comment)
    end
end
