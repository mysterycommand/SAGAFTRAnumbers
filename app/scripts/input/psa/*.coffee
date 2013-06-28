define [
  'jquery'
  'underscore'

  'input/psa/psa-radio'
  'input/psa/psa-television-on-camera'
  'input/psa/psa-television-off-camera'
], ($, _, PublicServiceAnnouncementRadio, PublicServiceAnnouncementTelevisionOnCamera, PublicServiceAnnouncementTelevisionOffCamera) ->
  exports =
    'Radio': PublicServiceAnnouncementRadio
    'OnCamera': PublicServiceAnnouncementTelevisionOnCamera
    'OffCamera': PublicServiceAnnouncementTelevisionOffCamera

  exports
