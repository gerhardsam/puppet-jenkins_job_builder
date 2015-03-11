require 'spec_helper'
describe 'jenkins_job_builder::service' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder::service') }
    it { should contain_exec('update jenkins-jobs').with({
        :command     => 'jenkins-jobs --conf /etc/jenkins_jobs/jenkins_jobs.ini update /var/lib/jenkins/jenkins-jobs-builder',
        :refreshonly => true,
      })
    }
  end

  context 'with different configuration_file' do
    let (:params) {
      {
        :configuration_file => '/foo/bar.ini',
      }
    }
    it { should contain_exec('update jenkins-jobs').with({
        :command => 'jenkins-jobs --conf /foo/bar.ini update /var/lib/jenkins/jenkins-jobs-builder',
      })
    }
  end

  context 'with different jobs_path' do
    let (:params) {
      {
        :jobs_path => '/foo/bar',
      }
    }
    it { should contain_exec('update jenkins-jobs').with({
        :command => 'jenkins-jobs --conf /etc/jenkins_jobs/jenkins_jobs.ini update /foo/bar',
      })
    }
  end

end
