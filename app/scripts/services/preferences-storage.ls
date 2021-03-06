co2r.factory \preferencesStorage, ->
  class Preferences-storage
    (@defaults={})->

    defaults: {}
    storage-key-names-prefix: \setting-

    set: (name, new-value)->
      local-storage.setItem @storage-key-names-prefix + name, new-value

    get-and-maybe-set: (name, new-value)->
      setting = _handle-booleans local-storage.getItem @storage-key-names-prefix + name
      if setting?
        setting
      else
        @set name, new-value
        new-value

    # if this setting has never been set, save it using the default value
    # and return the default value
    get: (name)->
      setting = _handle-booleans local-storage.getItem @storage-key-names-prefix + name
      if setting?
        setting
      else
        @set name, @defaults[name]
        @defaults[name]

    # restore all settings if not limited to specific ones
    restore-defaults: (names=_.keys(@defaults))->
      _.each names, ~> @set it, @defaults[it]


    # helpers

    function _handle-booleans(maybe-boolean)
      { 'true':true, 'false':false }[maybe-boolean] ? maybe-boolean

  new Preferences-storage {show-introduction: yes}
