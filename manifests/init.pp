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
# [*jobs_path*]
#   The path to the jjb jobs definitions.
#     May be a specific file or a directory containing them.
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
  $jjb_repo_url           = $jenkins_job_builder::params::jjb_repo_url,
  $packages               = $jenkins_job_builder::params::packages,
  $pip_packages           = $jenkins_job_builder::params::pip_packages,
  $jjb_config_parent_dirs = $jenkins_job_builder::params::jjb_config_parent_dirs,
  $configuration_file     = $jenkins_job_builder::params::configuration_file,
  $owner                  = $jenkins_job_builder::params::owner,
  $group                  = $jenkins_job_builder::params::group,
  $jenkins_url            = $jenkins_job_builder::params::jenkins_url,
  $jobs_path              = $jenkins_job_builder::params::jobs_path,
) inherits jenkins_job_builder::params {
  validate_string($jjb_repo_url, $configuration_file, $jobs_path)
  validate_array($packages, $pip_packages)

  include jenkins_job_builder::install
  include jenkins_job_builder::config
  include jenkins_job_builder::service
  Class ['jenkins_job_builder::install'] ->
  Class ['jenkins_job_builder::config'] ->
  Class ['jenkins_job_builder::service']
}
