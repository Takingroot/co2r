app_data = data =

  srcs:
    logo: "http://co2r.com/images/co2_emblem_service.gif"
    introduction_figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"

  defaults:
    co2_per_unit_unit: 'kg'

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
