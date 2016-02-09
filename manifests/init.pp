# Class: mongodb
# ===========================
#
# Installs mongodb on Ubuntu or Centos
#
# Examples
# --------
#
# @example
#    class { 'mongodb':
#    }
#
# Authors
# -------
#
# Neil Parley
#

class mongodb {

  include mongodb::install

}