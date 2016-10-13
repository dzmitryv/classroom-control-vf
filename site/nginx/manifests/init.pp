class nginx {
  include repo
  package { 'nginx':
	ensure => present,
	require	=> Yumrepo['updates'],
  }
  
  File {
	owner => 'root',
	group => 'root',
	mode = '0644',
  }
  
  file {'/var/www':
	require => Package['nginx'],
	ensure => directory,
  }

  file {'/var/www/index.html':
	require => File['/var/www'],
	ensure => file,
	source => 'puppet:///modules/nginx/index.html',
  }

  file {'/etc/nginx/nginx.conf':
	require => Package['nginx'],
	ensure => file,
	source => 'puppet:///modules/nginx/nginx.conf',
  }

  file {'/etc/nginx/conf.d/default.conf':
	require => Package['nginx'],
	ensure => file,
	source => 'puppet:///modules/nginx/default.conf',
  }
  
  service {'nginx':
	ensure => running,
	enable => true,
	subscribe => File['/etc/nginx/nginx.conf', '/etc/nginx/conf.d/default.conf'],
  }
}