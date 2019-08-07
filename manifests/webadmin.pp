# == Definition: nagios::webadmin
#
# Simple wrapper to ease apache configuration for nagios.
#
define nagios::webadmin(
  $vhost,
  $htpasswd_file,
  $ensure        = present,
) {

  file {"/var/www/${vhost}/conf/nagios.conf":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => epp(
      'nagios/apache.conf.epp',
      {
        cgi_dir            => $::nagios_cgi_dir,
        stylesheets_dir    => $::nagios_stylesheets_dir,
        physical_html_path => $::nagios_physical_html_path,
        vhost              => $vhost,
        htpasswd_file      => $htpasswd_file,
      },
    ),
    notify  => Exec['apache-graceful'],
  }

}
