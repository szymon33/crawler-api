module API::V1
  class HomesController < APIController
    def search
      result = MasClient.new(query).build
      render json: result, status: 200
    end

    def status
      render json: MasClient.status, status: 200
    end

    private

    def query
      @query ||= params[:query]
    end
  end
end
