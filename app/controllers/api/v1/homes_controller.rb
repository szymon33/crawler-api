module API::V1
  class HomesController < APIController
    def search
      render json: { message: 'OK' }, status: 200
    end
  end
end
