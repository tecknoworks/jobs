require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  before(:each) do
    Job.delete_all
    create :job
  end

  it 'get all jobs' do
    get :index, format: :json
    expect(json['code']).to eq(200)
    expect(json['body'].count).to eq(1)

    create :job
    create :job

    get :index, format: :json
    expect(json['code']).to eq(200)
    expect(json['body'].count).to eq(3)
  end

  it 'get by id' do
    job = create :job, title: 'test'
    job2 = create :job, title: 'foo', description: 'description'

    get :show, id: job.id, format: :json
    expect(json['code']).to eq(200)
    expect(json['body']['title']).to eq('test')

    get :show, id: job2.id, format: :json
    expect(json['code']).to eq(200)
    expect(json['body']['title']).to eq('foo')
    expect(json['body']['description']).to eq('description')
  end
end
