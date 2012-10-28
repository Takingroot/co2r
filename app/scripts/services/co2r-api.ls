# wrap the $http service into a co2r api DSL
module.exports = ($http, preferences-storage)->

  api-url  = "http://co2r-data-staging.herokuapp.com/api/"

  return
    post: (resource-url, custom-req-config)->
      req-config = _.defaults custom-req-config, {url: api-url+resource-url, method: \POST}
      $http req-config

    get: (resource-url, custom-req-config)->
      # TODO the locale api call doesn't need ?language= in it
      base-req-config =
        params:
          language: preferences-storage.get(\languageCode) or \en
      req-config = _.defaults base-req-config, custom-req-config, {url: api-url+resource-url, method: \GET}
      $http req-config
