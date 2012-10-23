# TODO rather than refresh toolbox from this button
# can we do it from a toolbox directive?
# what happens if we need other calls to refresh toolbox?
module.exports = (m)->

  m.directive \addthisButtonTweet, ->
    restrict: \C
    scope:
      use-title: \@
    link: (scope, el, attrs)->
      #console.log scope, el.parent!, attrs

      scope.$watch \useTitle, (new-title)->
        if new-title

          share-object =
            title: new-title

          # Warning! multiple calls to toolbox are ignored
          # so we only have one chance to adjust the content?!
          addthis.toolbox \.addthis_toolbox, {}, share-object
