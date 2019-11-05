require 'rails_helper'

RSpec.describe CheckWebsiteJob, type: :job do
  let(:website) { build(:website) }

  it 'calls Services::CheckWebsite#call' do
    expect(Services::CheckWebsite).to receive(:call).with(website)
    CheckWebsiteJob.perform_now(website)
  end
end
