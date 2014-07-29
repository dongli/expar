module API
  module V1
    class Experiments < Grape::API
      include API::V1::Defaults

      desc 'Return the list of experiments.'
      get 'list_experiments' do
        Experiment.all.to_json
      end

      desc 'Reture an experiment.'
      params do
        requires :id, type: Integer, desc: 'Experiment id.'
      end
      get 'get_experiment/:id' do
        begin
          Experiment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!('Experiment is not found', 404)
        end
      end

      http_basic do |email, password|
        authenticate_user(email, password)
      end

      class ExperimentParameters < Grape::Validations::Validator
        def validate_param!(attr_name, params)
          unless params[attr_name].has_key?('title')
            throw :error, status: 400, message: 'Missing experiment title!'
          end
          unless params[attr_name].has_key?('model')
            throw :error, status: 400, message: 'Missing experiment model!'
          end
          unless params[attr_name].has_key?('component_versions')
            throw :error, status: 400, message: 'Missing experiment component_versions!'
          end
          unless params[attr_name].has_key?('component_resolutions')
            throw :error, status: 400, message: 'Missing experiment component_resolutions!'
          end
          unless params[attr_name].has_key?('date')
            throw :error, status: 400, message: 'Missing experiment date!'
          end
          unless params[attr_name].has_key?('contact')
            throw :error, status: 400, message: 'Missing experiment contact!'
          end
          unless params[attr_name].has_key?('email')
            throw :error, status: 400, message: 'Missing experiment email!'
          end
          unless params[attr_name].has_key?('comment')
            throw :error, status: 400, message: 'Missing experiment comment!'
          end
        end
      end
      desc 'Create an experiment.'
      params do
        requires :experiment, experiment_parameters: true
      end
      post 'create_experiment' do
        user_must_be_authenticated!
        Model.all.each do |m|
          if params[:experiment][:model] == m.title
            params[:experiment][:model_id] = m.id
            params[:experiment].delete(:model)
            break
          end
        end
        strong_params = ActionController::Parameters.new(params)
        experiment = Experiment.new(strong_params.
                                    require(:experiment).
                                    permit(:title,
                                           :model_id,
                                           :date,
                                           :contact,
                                           :email,
                                           :created_by_user,
                                           :component_versions,
                                           :component_resolutions,
                                           :comment))
        experiment.created_by_user = current_user.id
        if experiment.save
          experiment
        else
          error!('Failed to create experiment!', 400)
        end
      end

      desc 'Delete an experiment.'
      params do
        requires :id, type: Integer, desc: 'Experiment id.'
      end
      get 'delete_experiment/:id' do
        user_must_be_authenticated!
        begin
          experiment = Experiment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!('Experiment is not found', 404)
        end
        if experiment.destroy
          'true'
        else
          'false'
        end
      end
    end
  end
end
