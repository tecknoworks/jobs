require 'rails_helper'

RSpec.describe Attachment, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobs/1/candidates/1/attachments').to route_to(controller: 'attachments', action: 'index', format: :json, job_id: '1', candidate_id: '1')
  end

  it 'routes to #show' do
    expect(get: '/api/jobs/1/candidates/1/attachments/1').to route_to(controller: 'attachments', action: 'show', format: :json, job_id: '1', candidate_id: '1', id: '1')
  end
end
