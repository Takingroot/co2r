window.app_data =
  partials-path: "/partials"

app_data <<<

  default-user-preferences:
    show-introduction: yes

  urls:
    logo: "http://co2r.com/images/co2_emblem_service.gif"
    introduction_figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"
    api: "http://co2r-data-staging.herokuapp.com/api"
    # kml url is set in init.ls because it needs a language-code

  defaults:
    co2_per_thing_made_unit: 'kg'
