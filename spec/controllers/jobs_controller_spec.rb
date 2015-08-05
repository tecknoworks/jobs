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
    job = create :job, description: 'test'
    job2 = create :job, description: 'description'
    job3 = create :job, description: "Ruby\n here is description for ruby...\n test"

    get :show, id: job.id, format: :json
    expect(json['code']).to eq(200)
    expect(json['body']['title']).to eq('test')

    get :show, id: job2.id, format: :json
    expect(json['code']).to eq(200)
    expect(json['body']['title']).to eq('description')
    expect(json['body']['description']).to eq('description')

    get :show, id: job3.id, format: :json
    expect(json['code']).to eq(200)
    expect(json['body']['title']).to eq('Ruby')
    expect(json['body']['description']).to eq("Ruby\n here is description for ruby...\n test")
  end
end
