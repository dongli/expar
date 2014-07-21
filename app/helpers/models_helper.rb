module ModelsHelper
  def model_contains_component?(component)
    # if @model
    @model.components.include?(component)
    # else
    #   false
    # end
  end
end
