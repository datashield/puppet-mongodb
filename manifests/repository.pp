class mongodb::repository {

  case $::operatingsystem {
    'Ubuntu': {
      include ::apt
      apt::source { 'mongodb':
        location    => 'http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2',
        release     => 'multiverse',
        repos       => '',
        key => { 'server' => 'hkp://keyserver.ubuntu.com:80', 'id' =>  '42F3E95A2C4F08279C4960ADD68FA50FEA312927'},
        include => { 'src' => false },
        notify      => Class['apt::update'],
      }
    }
    'Centos': {
      yumrepo { 'mongodb':
        ensure     => 'present',
        descr      => 'MongoDB Repository',
        enabled    => '1',
        gpgcheck   => '0',
        baseurl    => 'https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.2/x86_64/',
      }
    }
  }
}