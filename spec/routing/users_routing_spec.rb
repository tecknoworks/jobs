require 'rails_helper'

RSpec.describe User, type: :routing do
  it 'routes to #login' do
    expect(put: '/api/login').to route_to(controller: 'users', action: 'login', format: :json)
  end

  it 'routes to #logout' do
    expect(delete: '/api/logout/1').to route_to(controller: 'users', action: 'logout', id: '1', format: :json)
  end

  it 'routes to #logged' do
    expect(get: '/api/logged/1').to route_to(controller: 'users', action: 'logged', id: '1', format: :json)
  end
end
