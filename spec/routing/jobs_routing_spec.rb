require 'rails_helper'

RSpec.describe Job, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobs').to route_to(controller: 'jobs', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/jobs/1').to route_to(controller: 'jobs', action: 'show', id: '1', format: :json)
  end

  it 'routes to #create' do
    expect(post: '/api/jobs').to route_to(controller: 'jobs', action: 'create', format: :json)
  end

  it 'routes to #destroy' do
    expect(delete: '/api/jobs/1').to route_to(controller: 'jobs', action: 'destroy', id: '1', format: :json)
  end

  it 'routes tot #update' do
    expect(patch: '/api/jobs/1').to route_to(controller: 'jobs', action: 'update', id: '1', format: :json)
  end
end
