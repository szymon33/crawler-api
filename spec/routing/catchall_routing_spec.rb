require 'rails_helper'

describe 'catch all route', type: :routing do
  subject { api_get 'blabla' }

  it { should be_routable }
  it {
    should route_to(subdomain: 'api',
                    format: 'json',
                    controller: 'api/v1/api',
                    action: 'render_not_found',
                    path: 'blabla')
  }
end
