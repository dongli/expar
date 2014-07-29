module API
  module V1
    class Diags < Grape::API
      include API::V1::Defaults

      http_basic do |email, password|
        authenticate_user(email, password)
      end

      class DiagParameters < Grape::Validations::Validator
        def validate_param!(attr_name, params)
          unless params[attr_name].has_key?('experiment_id')
            throw :error, status: 400, message: 'Missing experiment_id!'
          end
          unless params[attr_name].has_key?('category')
            throw :error, status: 400, message: 'Missing diagnostics category!'
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
      desc 'Create a diagnostics.'
      params do
        requires :diag, diag_parameters: true
      end
      post 'create_diag' do
        user_must_be_authenticated!
        category = params[:diag][:category].downcase
        Diag.categories.each do |category_name, category_id|
          if category == category_name
            params[:diag][:category] = category_id
            break
          end
        end
        strong_params = ActionController::Parameters.new(params)
        diag = Diag.new(strong_params.
                        require(:diag).
                        permit(:experiment_id,
                               :category,
                               :contact,
                               :email,
                               :created_by_user,
                               :comment))
        diag.created_by_user = current_user.id
        if diag.save
          diag
        else
          error!('Failed to create diagnostics!', 400)
        end
      end

      desc 'Delete a diagnostics.'
      params do
        requires :id, type: Integer, desc: 'Diagnostics id.'
      end
      get 'delete_diag/:id' do
        user_must_be_authenticated!
        begin
          diag = Diag.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          error!('Diagnostics is not found', 404)
        end
        if diag.destroy
          'true'
        else
          'false'
        end
      end
    end
  end
end
