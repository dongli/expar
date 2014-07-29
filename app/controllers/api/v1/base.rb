module API
  module V1
    class Base < Grape::API
      mount API::V1::Experiments
      mount API::V1::Diags
      mount API::V1::Figures
    end
  end
end
