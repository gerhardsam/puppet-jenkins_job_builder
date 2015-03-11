# == Class: jenkins_job_builder::install
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
#    packages     => ['git'],
#    pip_packages => ['pbr'],
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
  $jjb_repo_url = $jenkins_job_builder::jjb_repo_url,
  $packages     = [
    'git',
    'python-setuptools',
    'python-pip'
  ],
  $pip_packages = [
    'pbr',
  ],
) inherits jenkins_job_builder {

  validate_string($jjb_repo_url)
  validate_array($packages, $pip_packages)

  ensure_packages($packages)
  ensure_packages($pip_packages, { 'provider' => 'pip' } )

  $repo_name           = 'jenkins-job-builder'
  $download_parent_dir = '/tmp/download'
  $jjb_repo_path       = "${download_parent_dir}/${repo_name}"

  $repo_file_paths = [
    $download_parent_dir,
    $jjb_repo_path
  ]

  file { $repo_file_paths:
    ensure => directory,
  }

  vcsrepo { $repo_name:
    ensure   => present,
    path     => $jjb_repo_path,
    provider => git,
    source   => $jjb_repo_url,
    require  => [
      Package['git'],
      File[$jjb_repo_path],
    ]
  }
}
