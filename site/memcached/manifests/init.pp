class memcached {
  package { 'memcached':
	ensure => present,  
  }
  
  file {'/etc/sysconfig/memcached':
	require => Package['memcached'],
	ensure => file,
	source => 'puppet:///modules/memcached/memcached',
  }
  
  service {'memcached':
	ensure => running,
	enable => true,
	subscribe => File['/etc/sysconfig/memcached'],
  }
}