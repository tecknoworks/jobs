require 'rails_helper'

RSpec.describe Attachment, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/attachments').to route_to(controller: 'attachments', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/attachments/1').to route_to(controller: 'attachments', action: 'show', id: '1', format: :json)
  end

  it 'routes to #create' do
    expect(post: '/api/attachments').to route_to(controller: 'attachments', action: 'create', format: :json)
  end

  it 'routes to #destroy' do
    expect(delete: '/api/attachments/1').to route_to(controller: 'attachments', action: 'destroy', id: '1', format: :json)
  end
end
