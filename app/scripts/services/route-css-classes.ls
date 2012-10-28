module.exports = ($location, $route-params)->

  # resolve homepage edgecase wherein no class info can be inferred from url
  get_url = ->
    path = $location.path!
    if path is "/" then \directory else path

  return
    get-all-classes: ->
      _.union _.keys($route-params), _.values($route-params), _.str.cssClassify(get_url!).split(" ")
