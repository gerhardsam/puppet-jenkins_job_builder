# == Class: jenkins_job_builder::config
#
# Configures the Jenkins Job Builder from OpenStack.
#
# === Parameters
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
#  include jenkins_job_builder::config
#
#  class { 'jenkins_job_builder::config': }
#
# === Authors
#
# Sebastian Gerhards <sebastian.gerhards@aktion-mensch.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Gerhards, unless otherwise noted.
#
class jenkins_job_builder::config(
  $jjb_config_parent_dirs = $jenkins_job_builder::jjb_config_parent_dirs,
  $configuration_file     = $jenkins_job_builder::configuration_file,
  $owner                  = $jenkins_job_builder::owner,
  $group                  = $jenkins_job_builder::group,
) inherits jenkins_job_builder {

  validate_string($configuration_file, $owner, $group)
  validate_array($jjb_config_parent_dirs)

  file { $jjb_config_parent_dirs:
    ensure => directory,
    owner  => $owner,
    group  => $group,
  }

  file { 'jjb configuration file':
    ensure  => present,
    path    => $configuration_file,
    content => template("${module_name}/jenkins_jobs.ini.erb"),
    owner   => $owner,
    group   => $group,
    require => File[$jjb_config_parent_dirs],
  }

}
