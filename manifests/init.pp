# == Class: jenkins_job_builder
#
# Installs Jenkins Job Builder from OpenStack.
#
# === Parameters
#
# [*jjb_repo_url*]
#   The URL to the repository where the Jenkins Job Builder gets checked out from.
#
# [*packages*]
#   Array of packages which should be installed as prerequisite for jjb installation.
#
# [*pip_packages*]
#   Array of packages which should be installed via pip as prerequisite for jjb installation.
#
# [*jjb_config_parent_dirs*]
#   Array of directory paths which should be created before placing the configuration file in them.
#
# [*configuration_file*]
#   The path to the jjb configuration file.
#
# [*owner*]
#   The owner of the configuration file and its parent directories.
#
# [*group*]
#   The group of the configuration file and its parent directories.
#
# === Variables
#
# No special variables.
#
# === Examples
#
#  include jenkins_job_builder
#
#  class { 'jenkins_job_builder': }
#
#  class { 'jenkins_job_builder':
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
class jenkins_job_builder(
  $jjb_repo_url           = 'https://git.openstack.org/openstack-infra/jenkins-job-builder',
  $packages               = [
    'git',
    'python-setuptools',
    'python-pip'
  ],
  $pip_packages           = [
    'pbr',
  ],
  $jjb_config_parent_dirs = [
    '/etc/jenkins_jobs',
  ],
  $configuration_file     = '/etc/jenkins_jobs/jenkins_jobs.ini',
  $owner                  = 'root',
  $group                  = 'root',
  $jenkins_url            = 'http://localhost:8080',
) {
  validate_string($jjb_repo_url, $configuration_file, $owner, $group)
  validate_array($packages, $pip_packages, $jjb_config_parent_dirs)

  include jenkins_job_builder::install
  include jenkins_job_builder::config
  Class ['jenkins_job_builder::install'] ->
  Class ['jenkins_job_builder::config']
}
