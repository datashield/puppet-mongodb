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

  include stdlib

  class { 'mongodb::repository': before => Package['mongodb-org'] }

  package { 'mongodb-org':
    ensure    => latest,
  }
  ~> service { 'mongod':
    ensure  => running,
    enable  => true,
  }

  if ($local_only_access)  {
    file_line { 'bindIp':
      ensure  => present,
      path    => '/etc/mongod.conf',
      line    => '  bindIp: 127.0.0.1',
      match   => '^#\ \ bindIp: 127.0.0.1',
      require => Package['mongodb-org'],
      notify  => Service['mongod'],
    }
  } else {
    file_line { 'bindIp':
      ensure  => present,
      path    => '/etc/mongod.conf',
      line    => '#  bindIp: 127.0.0.1',
      match   => '^\ \ bindIp: 127.0.0.1',
      require => Package['mongodb-org'],
      notify  => Service['mongod'],
    }
  }

  file_line { 'authorization':
    ensure  => present,
    path    => '/etc/mongod.conf',
    line    => 'security.authorization: enabled',
    match   => '^#security:',
    require => Package['mongodb-org'],
    notify  => Service['mongod'],
    before  => Exec[$create_user],
  }

  $create_user = "sleep 10 && mongo admin --eval 'db.createUser({user: \"opaluser\", pwd: \"opalpass\", roles: [ { role: \"root\", db: \"admin\" } ]})'"
  $test_user = "sleep 10 && mongo admin --port 27017 -u \"opaluser\" -p \"opalpass\" --authenticationDatabase \"admin\" --eval 'db.getUsers()'"

  exec { $create_user:
    path        => ["/usr/bin", "/usr/sbin", "/bin"],
    require     => [Service['mongod'], File_Line['authorization'], File_Line['bindIp']],
    unless      => $test_user,
  }

}