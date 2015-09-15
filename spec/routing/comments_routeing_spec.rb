require 'rails_helper'

RSpec.describe Comment, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/comments').to route_to(controller: 'comments', action: 'index', format: :json)
  end

  it 'routes to #create' do
    expect(post: '/api/comments').to route_to(controller: 'comments', action: 'create', format: :json)
  end
end
