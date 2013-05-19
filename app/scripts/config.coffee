require.config
  deps: ['main']
  paths:
    'jquery': '../bower_components/jquery/jquery'
    'underscore': '../bower_components/lodash/lodash'
    'webshim': '../bower_components/webshim/src/polyfiller'
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
