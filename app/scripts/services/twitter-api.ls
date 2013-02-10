

co2r.factory \twitterApi, ($http)->

  /*
   *  required param-options
   *    screen_name: <String>
  */
  get-user-timeline: (param-options)->
    param-defaults =
      include_rts     : yes
      user_name       : \twitter
      count           : 5
      clientsource    : \TWITTERINC_WIDGET
      '1340767850386' : \cachebus
    req-config =
      method          : \jsonp
      url             : "http://api.twitter.com/1/statuses/user_timeline.json"
      params          :
        callback        : \JSON_CALLBACK
    req-config.params = _.defaults req-config.params, param-options, param-defaults
    $http req-config
