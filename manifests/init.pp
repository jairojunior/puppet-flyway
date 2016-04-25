class flyway(
  $install_source = 'https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0/flyway-commandline-4.0-linux-x64.tar.gz',
  $dirname = '/opt/flyway',
  $install_cache_dir = '/var/cache/wget') {

  ensure_packages(['wget'], {'ensure' => 'present'})
  $install_file = inline_template('<%=File.basename(URI::parse(@install_source).path)%>')

  file { $dirname:
    ensure => directory,
    mode   => '0755',
  }
  ->
  exec { "Download flyway from ${install_source}":
    command  => "wget -N -P ${install_cache_dir} ${install_source} --max-redirect=5",
    path     => ['/bin', '/usr/bin', '/sbin'],
    loglevel => 'notice',
    creates  => "${install_cache_dir}/${install_file}",
    unless   => "test -f ${dirname}/flyway",
  }
  ~>
  exec { "untar ${install_file}":
    command  => "tar --no-same-owner --no-same-permissions --strip-components=1 -C ${dirname} -zxvf ${install_cache_dir}/${install_file}",
    path     => ['/bin', '/usr/bin', '/sbin'],
    loglevel => 'notice',
    creates  => "${dirname}/flyway",
  }

}
