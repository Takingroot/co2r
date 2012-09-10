window.getLocalStorageBool = (get_key)->
  init_val = localStorage.getItem get_key
  if _.contains ['true','1'], init_val
    true
  else if _.contains ['false','0'], init_val
    false
  else
    # probably undefined
    init_val



controller_directory = ($rootScope, $scope)->
  $rootScope.page_title = "Directory"
