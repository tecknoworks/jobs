require 'rails_helper'

RSpec.describe Job, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobs').to route_to(controller: 'jobs', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/jobs/1').to route_to(controller: 'jobs', action: 'show', format: :json, id: '1')
  end

  it 'routes to #create' do
    expect(post: '/api/jobs').to route_to(controller: 'jobs', action: 'create', format: :json)
  end
end
