# == Class: jenkins_job_builder
#
# Installs Jenkins Job Builder from OpenStack.
#
# === Parameters
#
# No special parameters.
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
# === Authors
#
# Sebastian Gerhards <sebastian.gerhards@aktion-mensch.de>
#
# === Copyright
#
# Copyright 2015 Sebastian Gerhards, unless otherwise noted.
#
class jenkins_job_builder {
  include jenkins_job_builder::install
}
