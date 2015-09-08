require 'rails_helper'

RSpec.describe Interview, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/interviews').to route_to(controller: 'interviews', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/interviews').to route_to(controller: 'interviews', action: 'index', format: :json)
  end

  it 'routes to #create' do
    expect(post: '/api/interviews').to route_to(controller: 'interviews', action: 'create', format: :json)
  end

  it 'routes to #destroy' do
    expect(delete: '/api/interviews/1').to route_to(controller: 'interviews', action: 'destroy', id: '1', format: :json)
  end
end
