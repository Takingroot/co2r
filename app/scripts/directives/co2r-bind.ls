module.exports = ($compile)->
  (scope, el, attrs)->
    # content might have html or angular directives
    scope.$watch attrs.co2r-bind, (content)->
      # if content is undefined then maybe there is an error
      # in the content within co2r-bind?
      if content?
        if content[0] is '<' and content[*-1] is '>'
          el.html $compile(content)(scope)
        else if not (_.str.include content, '<' or _.str.include content, '>')
          el.text content
        else
          if (el.prop \tagName) is \SPAN
            wrapper = $ "<span></span>"
          else
            wrapper = $ "<div></div>"
          # We have to wrap because leading/trailing text in html strings is trimmed...
          # quote: When passing HTML to jQuery(), please also note that text nodes are not treated as DOM elements. With the exception of a few methods (such as .content()), they are generally otherwise ignored or removed. E.g:
          # http://api.jquery.com/jQuery/
          wrapped-content = wrapper.html content
          el.html $compile(wrapped-content)(scope)
