_.mixin
  # {}, String
  # String should be something.that.has.dots.to.traverse.with
  #
  # use string dot-notation to traverse an object
  # For example the following are equivilant
  # 1. foo = bar.dig.deep.into.this.object
  # 2. foo = _.traverse(bar, 'dig.deep.into.this.object')
  traverse: (o,string)->
    path = string.split(".")
    at_value = o
    for part in path
      if at_value?
        at_value = at_value[part]
      else
        throw "Traversing undefined part for object: #{o}"
    at_value
