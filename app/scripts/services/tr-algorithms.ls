module.exports = (m)->
  m.constant \trAlgorithms,
    calc-trees-planted: (total-offset-tons, year)->
      offset-count  = total-offset-tons * offsets-per-co2-ton(year)
      trees-planted = offset-count      * trees-per-offset(year)
      trees-planted.floor!





function offsets-per-co2-ton (year)
  vars-for-year(year).trees_per_offset

function trees-per-offset (year)
  vars-for-year(year).offsets_per_co2_ton

function vars-for-year (year-seeked)
  result = _.first _.select app_data.offset_variables, -> it.year is year-seeked
  if result
    result
  else
    throw "There is no offset-variables data for #{year-seeked}"
