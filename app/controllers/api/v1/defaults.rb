module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        version 'v1'
        format :json

        helpers do
          def current_user
            @current_user ||= nil
          end

          def authenticate_user(email, password)
            user = User.find_by_email(email)
            error!('User does not exist.', 403) if not user
            error!('Password is not correct.', 403) if not user.valid_password?(password)
            @current_user = user
          end

          def user_must_be_authenticated!
            if not @current_user
              error!('Failed to authenticate user!', 403)
            end
          end
        end
      end
    end
  end
end
