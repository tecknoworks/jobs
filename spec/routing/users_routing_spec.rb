require 'rails_helper'

RSpec.describe User, type: :routing do
  it 'routes to #login' do
    expect(put: '/api/login').to route_to(controller: 'users', action: 'login', format: :json)
  end
end
