module ModelsHelper
  def get_model(id)
    Model.all.find(id)
  end

  def model_contains_component?(component)
    # if @model
    @model.components.include?(component)
    # else
    #   false
    # end
  end
end
