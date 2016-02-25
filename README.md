# mongodb

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

A simple module for installing MongoDB on Ubuntu or Centos. This module sets up a root mongoDB user and turns on 
authentication. The username and password of the root using is given by `$username` and `$password`. This user will have
access to all the databases that are on the server.

## Usage

Simply include mongodb to install:

```puppet
class { 'mongodb':
  local_only_access  => true,
  username           => 'opaluser',
  password           => 'opalpass',
}
```

## Reference

### ::mongodb::install
 
```puppet
class mongodb::install ($username='user', $password='password', $local_only_access=true, $authentication_database='admin') 
```

This sub module installs and MongoDB package to the system and starts the mongod service. `username` is the username for
the root mongoDB user and `password` is the password for the root mongoDB user. If `local_only_access` is true then only
local connections to the database will be allowed. If the variable is false then all adapters will have access to the 
database. `$authentication_database` is the database that mongodb uses for authentication.

### ::mongodb::repository

```puppet
class mongodb::repository
``` 

Installs the MongoDB yum or apt-get repo onto the system. Called by ```install```

## Limitations

Has only been tested on Ubuntu 14.04 and Centos 7. Does not set any root passwords
for the MongoDB install. Does not install the MongoDB client.

## Development

Open source, pull requests welcomed. 

