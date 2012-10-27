# wrap the $http service into a co2r api DSL
module.exports = (m)->
  m.service \co2rApi, ($http)->

    api-url  = "http://co2r-data-staging.herokuapp.com/api/"

    return
      post: (resource-url, custom-req-config)->
        req-config = _.defaults custom-req-config, {url: api-url+resource-url, method: \POST}
        $http req-config

      get: (resource-url, custom-req-config)->
        base-req-config =
          params:
            language: app_data.user-language
        req-config = _.defaults base-req-config, custom-req-config, {url: api-url+resource-url, method: \GET}
        $http req-config
