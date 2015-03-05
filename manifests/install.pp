# == Class: jenkins_job_builder::install
#
# Installs Jenkins Job Builder from OpenStack.
#
# === Parameters
#
# [*jjb_repo_url*]
#   The URL to the repository where the Jenkins Job Builder gets checked out from.
#
# === Variables
#
# No special variables.
#
# === Examples
#
#  include jenkins_job_builder::install
#
#  class { 'jenkins_job_builder::install': }
#
#  class { 'jenkins_job_builder::install':
#    jjb_repo_url => 'https://example.com/jjb-repo',
#  }
#
# === Authors
#
# Sebastian Gerhards <sebastian.gerhards@aktion-mensch.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Gerhards, unless otherwise noted.
#
class jenkins_job_builder::install(
  $jjb_repo_url = 'https://git.openstack.org/openstack-infra/jenkins-job-builder',
) inherits jenkins_job_builder {

  validate_string($jjb_repo_url)

  ensure_packages('git')

  $download_parent_dir = '/tmp/download'

  file { 'jjb download parent dir':
    ensure => directory,
    path   => $download_parent_dir,
  }

  $clone_command = "git clone ${jjb_repo_url}"
  exec { 'clone jenkins-job-builder repo':
    command => $clone_command,
    cwd     => '/tmp/download',
    path    => '/usr/bin:/usr/sbin:/bin',
    timeout => 600,
    require => [
      File['jjb download parent dir'],
      Package['git']
    ],
  }
}
