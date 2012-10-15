window.app_data =
  partials-path: "/partials"

app_data <<<
  other_things_you_can_do:

    * label: "can_do.feedback.title"
      description: 'can_do.feedback.description'
      templateName: \can-do-feedback

    * label: "can_do.sponsor_co2r.title"
      description: 'can_do.sponsor_co2r.description'
      templateName: \can-do-sponsor_co2r

    * label: "can_do.recruit_company.title"
      description: 'can_do.recruit_company.description'
      templateName: \can-do-recruit_company

    * slug: "spread_word"
      label: "can_do.spread_word.title"
      description: 'can_do.spread_word.description'
      templateName: \can-do-spread-word


  default_user_preferences:
    show_introduction: yes
    # This default is only falled back upon if the user:
    # 1. Doesn't have their locale supported by us
    # 2. Haven't manually selected something (which will have saved a preference to localStorage )
    locale: 'en'

  urls:
    logo: "http://co2r.com/images/co2_emblem_service.gif"
    introduction_figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"

  defaults:
    co2_per_thing_made_unit: 'kg'



app_data.expansions =
  co2: '<span class="co2-keyword">CO<sub>2</sub></span>'
