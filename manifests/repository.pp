# Class: mongodb::repository
# ===========================
#
# Installs the mongodb yum or apt source repo to the system
#
#
# Examples
# --------
#
# @example
#    class { 'mongodb::repository':
#    }
#
# Authors
# -------
#
# Neil Parley
#
class mongodb::repository {

  case $::operatingsystem {
    'Ubuntu': {
      include ::apt
      apt::source { 'mongodb':
        location    => 'http://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0',
        release     => 'multiverse',
        repos       => '',
#        key         => { 'server' => 'http://repo.mongodb.org:80', 'id' => 'F5679A222C647C87527C2F8CB00A0BD1E2C63C11' },
        key         => 'F5679A222C647C87527C2F8CB00A0BD1E2C63C11',
        include     => { 'src' => false },
        notify      => Class['apt::update'],
#        allow_unsigned => false,
        allow_unsigned => true,
      }
    }
    'Centos': {
      yumrepo { 'mongodb':
        ensure     => 'present',
        descr      => 'MongoDB Repository',
        enabled    => '1',
        gpgcheck   => '0',
        baseurl    => 'https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/5.0/x86_64/',
      }
    }
  }
}
