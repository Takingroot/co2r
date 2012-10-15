_.str.replace = (search_for, replace_with, string)->
	String(string).replace search_for, replace_with

_.str.cssClassify = (a_string)->
  _.str.clean _.str.replace(/^-/g, "", _.str.replace(/\//g, " ", _.str.dasherize a_string))
