###
  Author: Matt Hayes
###

root = this
log = root.log
require = root.require

require.config(
  paths: {
    'jquery': '//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min'
  }
)

require [
  'jquery'
], ($) ->
  log 'It worked!'





























