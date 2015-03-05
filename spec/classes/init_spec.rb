require 'spec_helper'
describe 'jenkins_job_builder' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder') }
    it { should contain_class('jenkins_job_builder::install') }
  end

end
