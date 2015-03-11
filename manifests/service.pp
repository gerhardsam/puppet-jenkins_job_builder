# == Class: jenkins_job_builder::service
#
# Invokes the Jenkins Job Builder from OpenStack.
#
# === Parameters
#
# [*configuration_file*]
#   The path to the jjb configuration file.
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
#  include jenkins_job_builder::service
#
#  class { 'jenkins_job_builder::service': }
#
# === Authors
#
# Sebastian Gerhards <sebastian.gerhards@aktion-mensch.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Gerhards, unless otherwise noted.
#
class jenkins_job_builder::service(
  $configuration_file = $jenkins_job_builder::configuration_file,
  $jobs_path          = $jenkins_job_builder::jobs_path,
) inherits jenkins_job_builder {

  $update_jobs_cmd = "jenkins-jobs --conf ${configuration_file} update ${jobs_path}"

  exec { 'update jenkins-jobs':
    command     => $update_jobs_cmd,
    refreshonly => true,
    path        => '/usr/bin',
  }

}
