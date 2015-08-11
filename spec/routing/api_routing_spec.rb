require 'rails_helper'

RSpec.describe 'Api Routing', type: :routing do
  describe 'jobs' do
    it 'routes to #index' do
      expect(get: '/api/jobs').to route_to(controller: 'jobs', action: 'index', format: :json)
    end

    it 'routes to #show' do
      expect(get: '/api/jobs/1').to route_to(controller: 'jobs', action: 'show', format: :json, id: '1')
    end
  end

  describe 'candidates' do
    it 'routes to #index' do
      expect(get: '/api/jobs/1/candidates').to route_to(controller: 'candidates', action: 'index', format: :json, job_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/jobs/1/candidates/1').to route_to(controller: 'candidates', action: 'show', format: :json, job_id: '1', id: '1')
    end
  end

  describe 'attachments' do
    it 'routes to #index' do
      expect(get: '/api/jobs/1/candidates/1/attachments').to route_to(controller: 'attachments', action: 'index', format: :json, job_id: '1', candidate_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/jobs/1/candidates/1/attachments/1').to route_to(controller: 'attachments', action: 'show', format: :json, job_id: '1', candidate_id: '1', id: '1')
    end
  end
end
