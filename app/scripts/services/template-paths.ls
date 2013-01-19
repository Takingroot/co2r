


# make this a constant so we can use it even in <module>.config blocks
# it's a pure function so we don't need a factory version
co2r.services.constant \templatePartial, (template-name)->
  "/views/template-partials/#template-name.html"

co2r.services.constant \templateView, (view-name)->
  "/views/#view-name/template.html"
