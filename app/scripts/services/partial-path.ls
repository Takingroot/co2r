# make this a constant so we can use it even in <module>.config blocks
# it's a pure function so we don't need a factory version
co2r.services.constant \partialPath, (partial-name)->
    "/partials/#partial-name.html"
