class { 'openshift_origin':
  roles => [
    'named',
    'broker',
    'node',
    'activemq',
    'datastore',
  ],
  bind_key => 'x6O99Q2YoOk5W5BKKWErvSqVLS7VwA==',
}
