Rails.application.routes.draw do
  namespace :api, constraints: { subdomain: 'api' }, path: '/', defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      get :status, controller: 'heartbeat'

      match '*path', to: 'api#render_not_found', via: :all
    end
  end
end
