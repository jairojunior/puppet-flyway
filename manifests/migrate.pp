define flyway::migrate($url, $user, $password, $locations = "filesystem:${::flyway::dirname}", $target = 'latest version') {

  require flyway

  $options = "-X -url=${url} -user=${user} -password=${password} -locations=${locations} -target='${target}'"

  exec { "Migrate ${url} for ${locations}":
    command => "flyway ${options} migrate",
    unless  => "flyway ${options} validate",
    path    => ['/bin', '/usr/bin', '/sbin', $::flyway::dirname],
  }

}
