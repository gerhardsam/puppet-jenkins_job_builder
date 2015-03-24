# == Class: jenkins_job_builder::params
#
# This class holds the defaults for all parameters.
#
# === Parameters
#
# No parameters.
#
# === Variables
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
# [*jobs_path*]
#   The path to the jjb jobs definitions.
#     May be a specific file or a directory containing them.
#
# === Examples
#
#  include jenkins_job_builder::params
#
# === Authors
#
# Sebastian Gerhards <sebastian.gerhards@aktion-mensch.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Gerhards, unless otherwise noted.
#
class jenkins_job_builder::params {
  $jjb_repo_url           = 'https://git.openstack.org/openstack-infra/jenkins-job-builder'
  $packages               = [
    'git',
    'python-setuptools',
    'python-pip'
  ]
  $pip_packages           = [
    'pbr',
  ]
  $jjb_config_parent_dirs = [
    '/etc/jenkins_jobs',
  ]
  $configuration_file     = '/etc/jenkins_jobs/jenkins_jobs.ini'
  $owner                  = 'root'
  $group                  = 'root'
  $jenkins_url            = 'http://localhost:8080'
  $jobs_path              = '/var/lib/jenkins/jenkins-jobs-builder'

}
