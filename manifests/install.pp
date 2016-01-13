class mongodb::install  {

  class {'mongodb::repository': before => Package['mongodb-org']}

  package { 'mongodb-org':
    ensure    => latest,
  }
  ~> service { 'mongod':
    ensure  => running,
    enable => true,
  }

}