define flyway::migrate($url, $user, $password, $locations = "filesystem:${::flyway::dirname}", $target = 'latest version', $schemas = 'public') {

  require flyway

  $options = "-X -url=${url} -user=${user} -password=${password} -locations=${locations} -schemas='${schemas}' -target='${target}'"

  exec { "Migrate ${url} for ${locations}":
    command => "flyway ${options} migrate",
    unless  => "flyway ${options} validate",
    path    => ['/bin', '/usr/bin', '/sbin', $::flyway::dirname],
  }

}
