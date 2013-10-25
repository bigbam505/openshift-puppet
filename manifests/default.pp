package { 'bind':
  ensure => present,
}

exec { 'generate tsig key':
  command => "/usr/bin/rm -rf /var/named/Kexample.com* ; \
              /usr/sbin/dnssec-keygen -a HMAC-MD5 -b 512 -n USER -r /dev/urandom -K /var/named example.com",
  require => Package['bind'],
}

$dev='p2p1'
augeas{ 'network setup' :
  context => "/files/etc/sysconfig/network-scripts/ifcfg-${dev}",
  changes => [
    "set NAME ${dev}",
    'set ONBOOT yes',
    'set TYPE Ethernet',
    'set BOOTPROTO dhcp',
    'set PEERDNS no',
    'set DNS1 8.8.8.8',
  ],
}

$keyfile='/var/named/Kexample.com.*.key'
$key=inline_template('<%=File.read(Dir.glob(keyfile)[0]).strip.split(\' \')[7]%>')

class { 'openshift_origin' :
  node_fqdn                  => "${hostname}.${domain}",
  cloud_domain               => 'example.com',
  named_tsig_priv_key        => $::key,
  dns_servers                => ['8.8.8.8'],
  os_unmanaged_users         => ['vagrant'],
  enable_network_services    => true,
  configure_firewall         => true,
  configure_ntp              => true,
  configure_activemq         => true,
  configure_qpid             => false,
  configure_mongodb          => true,
  configure_named            => true,
  configure_broker           => true,
  configure_node             => true,
  development_mode           => true,
  configure_cgroups          => true,
  eth_device => 'p2p1'
}