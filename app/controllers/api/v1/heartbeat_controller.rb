module API::V1
  class HeartbeatController < APIController
    def status
      render json: { status: 'OK' }, status: 200
    end
  end
end
