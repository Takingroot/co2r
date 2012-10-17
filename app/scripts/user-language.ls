user-language = (callback)->
 $.ajax do
   url: "http://ajaxhttpheaders.appspot.com"
   dataType: \jsonp
   success: (headers)->
     language-code = headers[\Accept-Language].substring(0,2)
     callback language-code, headers[\Accept-Language]

module.exports = user-language
