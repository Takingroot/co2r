app_data =
  other_things_you_can_do:

    * label: "can_do.feedback.title"
      description: 'can_do.feedback.description'
      template: "/partials/can_do_feedback.html"

    * label: "can_do.sponsor_co2r.title"
      description: 'can_do.sponsor_co2r.description'
      template: "/partials/can_do_sponsor_co2r.html"

    * label: "can_do.recruit_company.title"
      description: 'can_do.recruit_company.description'
      template: "/partials/can_do_recruit_company.html"

    * slug: "spread_word"
      label: "can_do.spread_word.title"
      description: 'can_do.spread_word.description'
      template: "/partials/can_do_spread_word.html"


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
  co2: '<span class="co2-keyword">co<sub>2</sub></span>'
