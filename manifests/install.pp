# Class: mongodb::install
# ===========================
#
# Installs mongodb and makes sure the service is running. This module will turn on access control and will create a root
# user with the $username and $password given. This user will have access to all the mongodb databases.
#
# Parameters
# ----------
#
# * `username`
# Username of the root mongodb user
#
# * `password`
# Password of the root mongodb user
#
# * `local_only_access`
# If true then only allow connections from 127.0.0.1, i.e. local connections. If false allow connections to the database
# server from other adapters
#
# Examples
# --------
#
# @example
#    class { 'mongodb::install':
#      local_only_access  => true,
#      username           => 'opaluser',
#      password           => 'opalpass',
#    }
#
# Authors
# -------
#
# Neil Parley
#
class mongodb::install ($username='user', $password='password', $local_only_access=true)  {

  class { 'mongodb::repository': before => Package['mongodb-org'] }

  package { 'mongodb-org':
    ensure    => latest,
  }
  ~> service { 'mongod':
    ensure  => running,
    enable  => true,
  }

  if ($local_only_access)  {
    file { "/etc/mongod.conf":
      ensure  => directory,
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/mongodb/mongod_local.conf",
      require => Package['mongodb-org'],
      notify  => Service['mongod'],
    }
  } else {
    file { "/etc/mongod.conf":
      ensure  => directory,
      owner   => "root",
      group   => "root",
      source  => "puppet:///modules/mongodb/mongod_server.conf",
      require => Package['mongodb-org'],
      notify  => Service['mongod'],
    }
  }

  $create_user = "mongo admin --eval 'db.createUser({user: \"opaluser\", pwd: \"opalpass\", roles: [ { role: \"root\", db: \"admin\" } ]})'"
  $test_user = "mongo admin --port 27017 -u \"opaluser\" -p \"opalpass\" --authenticationDatabase \"admin\" --eval 'db.getUsers()'"

  exec { $create_user:
    alias       => 'mongodb_admin_user',
    path        => ["/usr/bin", "/usr/sbin"],
    require     => [File["/etc/mongod.conf"],Service['mongod']],
    unless      => $test_user,
  }

}