_.mixin do
  # {}, String
  # String should be something.that.has.dots.to.traverse.with
  #
  # use string dot-notation to traverse an object
  # For example the following are equivilant
  # 1. foo = bar.dig.deep.into.this.object
  # 2. foo = _.traverse(bar, 'dig.deep.into.this.object')
  traverse: (obj, string)->
    at-value  = obj

    for part in path-parts = string.split \.
      #TODO allow an existential operator to dig until first thing not found, instead of throwing
      if at-value?
        at-value = at-value[part]
      else
        throw "Traversing undefined part for object: #obj"

    at-value

