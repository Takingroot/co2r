data =
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
