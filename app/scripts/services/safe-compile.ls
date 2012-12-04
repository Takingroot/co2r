co2r.services.factory \safeCompile, ($compile)->

  #
  #  Options
  #  source | scope | wrapper-class
  #
  function safe-compile(opts)
    opts.wrapper-class ?= \content
    # wrapping is important because $compile will not work on plaintext, it needs a root-node
    wrapped-source = "<div class='#{opts.wrapper-class}-wrapper'>#{opts.source}</div>"
    $compile(wrapped-source)(opts.scope)
