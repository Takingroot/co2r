app_data =
  other_things_you_can_do: [
    {
      label: "can_do.feedback.title"
      description: 'can_do.feedback.description'
      template: "/partials/can_do_feedback.html"
    }
    {
      label: "can_do.sponsor_co2r.title"
      description: 'can_do.sponsor_co2r.description'
      template: "/partials/can_do_sponsor_co2r.html"
    }
    {
      label: "can_do.recruit_company.title"
      description: 'can_do.recruit_company.description'
      template: "/partials/can_do_recruit_company.html"
    }
    {
      slug: "spread_word"
      label: "can_do.spread_word.title"
      description: 'can_do.spread_word.description'
      template: "/partials/can_do_spread_word.html"
    }
  ]


  default_user_preferences:
    show_introduction: yes
    # This default is only falled back upon if the user:
    # 1. Doesn't have their locale supported by us
    # 2. Haven't manually selected something thus saving a preference to localStorage
    locale: 'en'

  urls:
    logo: "http://co2r.com/images/co2_emblem_service.gif"
    introduction_figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"

  defaults:
    co2_per_thing_made_unit: 'kg'

  calculation_variables:
    offsets_per_co2_ton: 1
    trees_per_offset:
      2012: 4
      2011: 4.3
      2010: 3.2
      2009: 2.9
      2008: 2.9
      2007: 2.9

  co2_comparisons: [
    {
      phrase: 'Driving'
      type: 'driving_car'
      unit: 'km'
      amount:     0.001
    }
    {
      phrase: 'Eating'
      type: 'eating_steak'
      unit: 'steaks'
      amount:    0.009
    }
    {
      phrase: 'Flushing your toilet'
      unit: 'times'
      type: 'flushing_toilet'
      amount: 0.00005
    }
  ]

app_data.expansions =
  co2: '<span class="co2-keyword">co<sub>2</sub></span>'
