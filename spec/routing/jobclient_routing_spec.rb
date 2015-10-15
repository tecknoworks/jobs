require 'rails_helper'

RSpec.describe JobclientController, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobclient').to route_to(controller: 'jobclient', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/jobclient/1').to route_to(controller: 'jobclient', action: 'show', id: '1', format: :json)
  end
end
