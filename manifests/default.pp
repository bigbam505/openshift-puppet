class { 'openshift_origin':
  roles => [
    'broker',
    'node',
    'activemq',
    'datastore',
  ],
}
