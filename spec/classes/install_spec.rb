require 'spec_helper'
describe 'jenkins_job_builder::install' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder::install') }
    it { should contain_package('git') }
    it { should contain_file('/tmp/download/jenkins-job-builder').with({
        :ensure => 'directory',
      })
    }
    it { should contain_vcsrepo('jenkins-job-builder') }
  end

end
