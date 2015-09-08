require 'rails_helper'

RSpec.describe Attachment, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/attachments').to route_to(controller: 'attachments', action: 'index', format: :json)
  end

  it 'routes to #show' do
    expect(get: '/api/attachments/1').to route_to(controller: 'attachments', action: 'show', format: :json, id: '1')
  end

  it 'routes to #create' do
    expect(post: '/api/attachments').to route_to(controller: 'attachments', action: 'create', format: :json)
  end

  it 'routes to #update' do
    expect(put: '/api/attachments/1').to route_to(controller: 'attachments', action: 'update', format: :json, id: '1')
  end

  it 'routes to #delete' do
    expect(delete: '/api/attachments/1').to route_to(controller: 'attachments', action: 'destroy', format: :json, id: '1')
  end
end
