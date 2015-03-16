require 'spec_helper'
describe 'jenkins_job_builder::install' do

  context 'with defaults for all parameters' do
    it { should contain_class('jenkins_job_builder::install') }
    it { should contain_package('git') }
    it { should contain_file('/tmp/download/jenkins-job-builder').with({
        :ensure => 'directory',
      })
    }
    it { should contain_vcsrepo('jenkins-job-builder').that_notifies('Exec[install jjb]') }
    it { should contain_exec('install jjb').with_refreshonly(true) }
  end

  context 'with different packages to be installed' do
    let (:params) {
      {
        :packages => [
            'foo',
            'bar'
        ],
      }
    }
    it {
      should contain_package('foo')
      should contain_package('bar')
    }
  end

  context 'packages parameter is not an array' do
    let(:params) { { :packages => 'not_an_array' } }
    it { should raise_error(Puppet::Error, /"not_an_array" is not an Array/) }
  end

  context 'with different packages to be installed via pip' do
    let (:params) {
      {
        :pip_packages => [
            'foo',
            'bar'
        ],
      }
    }
    it {
      should contain_package('foo').with_provider('pip')
      should contain_package('bar').with_provider('pip')
    }
  end

  context 'pip_packages parameter is not an array' do
    let(:params) { { :pip_packages => 'not_an_array' } }
    it { should raise_error(Puppet::Error, /"not_an_array" is not an Array/) }
  end

end
