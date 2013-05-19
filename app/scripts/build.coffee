require.config
  deps: ['main']
  paths:
    'jquery': '../../app/bower_components/jquery/jquery'
    'underscore': '../../app/bower_components/lodash/lodash'
    'webshim': '../../app/bower_components/webshim/src/polyfiller'
    'chosen': 'plugins/chosen/chosen'
  shim:
    'webshim':
      deps: ['jquery']
      exports: 'webshim'
    'chosen':
      deps: ['jquery']
      exports: 'chosen'
    'jquery':
      exports: '$'
