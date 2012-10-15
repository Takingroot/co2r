class PreferencesStorage
  (@defaults)->

  defaults: {}

  set: (name, new-value)->
    localStorage.setItem "setting_#name", new-value

  # if this setting has never been set, save it using the default value
  # and return the default value
  get: (name)->
    setting = _handle-booleans localStorage.getItem "setting_#name"
    setting ? @set name, @defaults[name] and @get name

  # restore all settings if not limited to specific ones
  restore-defaults: (names=_.keys(@defaults))->
    _.each names, ~> @set it, @defaults[it]


  # helpers

  function _handle-booleans(maybe-boolean)
    { 'true':true, 'false':false }[maybe-boolean] ? maybe-boolean
