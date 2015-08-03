require 'rails_helper'

RSpec.describe JobsController, type: :controller do
  render_views

  before(:all) do
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
end
