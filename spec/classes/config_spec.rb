require 'spec_helper'
describe 'jenkins_job_builder::config' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder::config') }
    it { should contain_file('/etc/jenkins_jobs').with({
        :ensure => 'directory',
        :owner  => 'root',
        :group  => 'root',
      })
    }
    it { should contain_file('jjb configuration file').with({
        :path    => '/etc/jenkins_jobs/jenkins_jobs.ini',
        :content => /url=http:\/\/localhost:8080/
      })
    }
  end

  context 'jjb_config_parent_dirs parameter is not an array' do
    let(:params) { { :jjb_config_parent_dirs => 'not_an_array' } }
    it { should raise_error(Puppet::Error, /"not_an_array" is not an Array/) }
  end

  context 'with different owner and group' do
    let (:params) {
      {
        :owner => 'owner',
        :group => 'group',
      }
    }
    it { should contain_file('/etc/jenkins_jobs').with({
        :ensure => 'directory',
        :owner  => 'owner',
        :group  => 'group',
      })
    }
    it { should contain_file('jjb configuration file').with({
        :path  => '/etc/jenkins_jobs/jenkins_jobs.ini',
        :owner => 'owner',
        :group => 'group',
      })
    }
  end

  context 'with different parent directories' do
    let (:params) {
      {
        :jjb_config_parent_dirs => ['/foo', '/bar'],
      }
    }
    it { should contain_file('/foo').with({
        :ensure => 'directory',
      }).that_comes_before('File[jjb configuration file]')
    }
    it { should contain_file('/bar').with({
        :ensure => 'directory',
      }).that_comes_before('File[jjb configuration file]')
    }
    it { should contain_file('jjb configuration file').with({
        :path => '/etc/jenkins_jobs/jenkins_jobs.ini',
      })
    }
  end

end
