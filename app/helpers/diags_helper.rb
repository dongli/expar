module DiagsHelper
  def get_diag_experiment(id)
    diag = Diag.find(id)
    experiment = Experiment.find(diag.experiment_id)
  end
end
