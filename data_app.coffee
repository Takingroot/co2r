app_data =
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

app_data.locales = {}
app_data.locales.en =
  learn_more_about_co2r: "Learn more about the CO2R platform"
  learn_more: "Learn More"
  trees_planted: "%s Trees planted"
  introduction_title: "CO<sub>2</sub> Responsible"
  #TODO popovers in locales? i.e. popover here
  introduction_text: """
    <p class="lead">
      We help companies be responsble about the
      <a popover="{title: 'What is carbon?', content: 'accusantium doloremque laudantium, totam rem aperiam'}">carbon</a>
      their products emit into the atmosphere. We achieve this by planting enough trees in Nicaragua to negate their emissions.
    </p>
    <p>Sed ut perspiciatis unde omnis iste natus error [Taking Root] sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo.</p>
    """

  directory:
    filter_input_prompt: 'Filter Co2 responsible products by name'
  artifact_page:
    download_report: "Download the %s report"
    business_card_contact_lead_in: "Get in touch:"
    offset_since: "Offset since %s"
    reports_section_title: "Footprint Summary Reports"
    report_section_titles:
      other_eco_actions: 'Other Environmental actions'
      total_vs_offset: '%s for %s - vs - Co2 offset'
      co2_sources: '%s Sources'
      co2_per_thing_made: '%s for %s'
