app_data =
  default_user_preferences:
    show_introduction: yes

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
