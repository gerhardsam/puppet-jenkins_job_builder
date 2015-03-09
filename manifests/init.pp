# == Class: jenkins_job_builder
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
  $jjb_repo_url = 'https://git.openstack.org/openstack-infra/jenkins-job-builder',
) {
  validate_string($jjb_repo_url)
  include jenkins_job_builder::install
}
