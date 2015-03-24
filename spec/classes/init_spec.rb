require 'spec_helper'
describe 'jenkins_job_builder' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder') }
    it { should contain_class('jenkins_job_builder::params') }
    it { should contain_class('jenkins_job_builder::install').that_comes_before('jenkins_job_builder::config') }
    it { should contain_class('jenkins_job_builder::config').that_comes_before('jenkins_job_builder::service') }
    it { should contain_class('jenkins_job_builder::service') }
  end

  context 'packages parameter is not an array' do
    let(:params) { { :packages => 'not_an_array' } }
    it { should raise_error(Puppet::Error, /"not_an_array" is not an Array/) }
  end

  context 'pip_packages parameter is not an array' do
    let(:params) { { :pip_packages => 'not_an_array' } }
    it { should raise_error(Puppet::Error, /"not_an_array" is not an Array/) }
  end

end
