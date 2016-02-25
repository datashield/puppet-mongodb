# Class: mongodb
# ===========================
#
# Installs mongodb on Ubuntu or Centos. This module will turn on access control and will create a root user with the
# $username and $password given. This user will have access to all the mongodb databases.
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
# * `authentication_database`
# Database used for authentication
#
# Examples
# --------
#
# @example
#    class { 'mongodb':
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

class mongodb ($username='user', $password='password', $local_only_access=true, $authentication_database='admin') {

  class { mongodb::install:
    local_only_access       => $local_only_access,
    username                => $username,
    password                => $password,
    authentication_database => $authentication_database,
  }

}