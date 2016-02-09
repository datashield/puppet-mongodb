# mongodb

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

A simple module for installing MongoDB on Ubuntu or Centos. 

## Usage

Simply include mongodb to install:

```puppet
include ::mongodb
```

## Reference

```::mongodb::install```: This sub module installs and MongoDB package to the system and starts
the mongod service. 
```::mongodb::repository```: Installs the MongoDB yum or apt-get repo onto the system. Called by ```install```

## Limitations

Has only been tested on Ubuntu 14.04 and Centos 7. Does not set any root passwords
for the MongoDB install. Does not install the MongoDB client.

## Development

Open source, pull requests welcomed. 

