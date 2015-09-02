require 'rails_helper'

RSpec.describe Candidate, type: :routing do
  it 'routes to #index' do
    expect(get: '/api/jobs/1/candidates').to route_to(controller: 'candidates', action: 'index', format: :json, job_id: '1')
  end

  it 'routes to #show' do
    expect(get: '/api/jobs/1/candidates/1').to route_to(controller: 'candidates', action: 'show', format: :json, job_id: '1', id: '1')
  end

  it 'routes to #create' do
    expect(post: '/api/jobs/1/candidates').to route_to(controller: 'candidates', action: 'create', job_id: '1', format: :json)
  end
end
