class nagios(
  $use_syslog         = '1',
  $check_ping_ipv     = undef,
  $nrpe_server_tag    = $::fqdn,
  $nsca_server_tag    = $::fqdn,
  $niceness           = 5,
  $cgi_dir            = $::nagios_cgi_dir,
  $stylesheets_dir    = $::nagios_stylesheets_dir,
  $physical_html_path = $::nagios_physical_html_path,
) {
  case $::osfamily {
    'Debian': { include ::nagios::debian }
    'RedHat': { include ::nagios::redhat }
    default:  { fail ("OS family ${::osfamily} not yet implemented !")}
  }
}
