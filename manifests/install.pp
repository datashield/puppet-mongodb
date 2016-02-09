# Class: mongodb::install
# ===========================
#
# Installs mongodb and makes sure the service is running
#
#
# Examples
# --------
#
# @example
#    class { 'mongodb::install':
#    }
#
# Authors
# -------
#
# Neil Parley
#
class mongodb::install  {

  class { 'mongodb::repository': before => Package['mongodb-org'] }

  package { 'mongodb-org':
    ensure    => latest,
  }
  ~> service { 'mongod':
    ensure  => running,
    enable  => true,
  }

}