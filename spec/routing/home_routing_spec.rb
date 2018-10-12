require 'rails_helper'

describe 'status route', type: :routing do
  subject { api_get 'status' }

  it { should be_routable }
  it { should route_to(subdomain: 'api',
                       format: 'json',
                       controller: 'api/v1/heartbeat',
                       action: 'status') }
end
