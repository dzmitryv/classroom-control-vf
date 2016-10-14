define users::managed_user (
	$homedir = "/home/${title}",
	$password = 'test',
	$shell = '/bin/bash',
) {
  user { $title:
    ensure           => present,
    home             => $homedir,
    password         => $password,
    shell            => $shell,
  }
  file { $homedir:
	ensure => directory,
	require => User[$title],
  }
  file { "${homedir}/.ssh":
	ensure => directory,
	require => File[$homedir],
  }
}