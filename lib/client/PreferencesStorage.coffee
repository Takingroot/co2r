class PreferencesStorage

  constructor: (@defaults)->

  defaults: {}

  set: (name, value)->
    localStorage.setItem "setting_#{name}", value

  get: (name)->

    handle_booleans = (value)->
      if value is 'true'
        true
      else if value is 'false'
        false
      else
        value

    setting = handle_booleans(localStorage.getItem("setting_#{name}"))

    # if this setting has never been set, save it using the default value
    # and return the default value
    if not setting?
      @set(name, @defaults[name])
      @defaults[name]
    else
      setting

  restore_defaults: (names)->

    # restore all settings if not limited to specific ones
    if not names?
      names = _.keys @defaults

    _.each names, (name)=>
      @set(name, @defaults[name])
