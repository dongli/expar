module API
  module V1
    class Figures < Grape::API
      include API::V1::Defaults

      http_basic do |email, password|
        authenticate_user(email, password)
      end

      desc 'Create a figure.'
      params do
        requires :diag_id
        requires :title, type: String, desc: 'Figure title.'
        requires :file
        requires :comment, type: String, desc: 'Figure comment.'
      end
      post 'create_figure' do
        user_must_be_authenticated!
        begin
          Diag.find(params[:diag_id])
        rescue ActiveRecord::RecordNotFound
          error!('Diagnostics is not found', 404)
        end
        attachment = {
          :filename => params[:file].filename,
          :type => MIME::Types.type_for(params[:file].filename)[0].content_type,
          :headers => params[:file].head,
          :tempfile => params[:file].tempfile
        }
        file = ActionDispatch::Http::UploadedFile.new(attachment)
        strong_params =
          ActionController::Parameters.new({figure: {diag_id: params[:diag_id],
                                                     title: params[:title],
                                                     file: file,
                                                     comment: params[:comment]}})
        figure =
          Figure.new(strong_params.require(:figure).permit(:diag_id,
                                                           :title,
                                                           :file,
                                                           :created_by_user,
                                                           :comment))
        figure.created_by_user = current_user.id
        if figure.save
          figure
        else
          error!('Failed to create figure! Most likely due to wrong arguments.', 400)
        end
      end
    end
  end
end
