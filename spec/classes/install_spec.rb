require 'spec_helper'
describe 'jenkins_job_builder::install' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder::install') }
    it { should contain_package('git') }
    it { should contain_file('jjb download parent dir').with({
        :ensure => 'directory',
      })
    }
    it { should contain_exec('clone jenkins-job-builder repo') }
  end

end
