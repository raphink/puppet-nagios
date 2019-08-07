# == Definition: nagios::webadmin
#
# Simple wrapper to ease apache configuration for nagios.
#
define nagios::webadmin(
  $vhost,
  $htpasswd_file,
  $ensure             = present,
  $cgi_dir            = $::nagios::cgi_dir,
  $stylesheets_dir    = $::nagios::stylesheets_dir,
  $physical_html_path = $::nagios::physical_html_path,
) {

  file {"/var/www/${vhost}/conf/nagios.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => epp(
      'nagios/apache.conf.epp',
      {
        cgi_dir            => $cgi_dir,
        stylesheets_dir    => $stylesheets_dir,
        physical_html_path => $physical_html_path,
        vhost              => $vhost,
        htpasswd_file      => $htpasswd_file,
      },
    ),
    notify  => Exec['apache-graceful'],
  }

}
