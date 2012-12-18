


var bindCompile = angular.module('bindCompile', []).

//  Attributes Table       Watched  Default  Valid Values
//    bind-compile         Y        --       a String literal || expresssion evaling to a String
//    bind-compile-scope   N                 a Scope
//
//  Attributes details
//    bind-compile
//    Content to compile, can include HTML, directives, and/or bindings {{}}
//
//    bind-compile-scope
//    scope where directive is invoked  Scope to use for compiling content;
//
directive('bindCompile', ['$compile', function($compile){
  return {
    link: function(scope, element, attrs) {
      // The scope used for compiling is either an argument or
      // wherever this directive is used
      var compileScope = attrs.bindCompileScope ? scope.$eval(attrs.bindCompileScope) : scope;

      // $compile takes care of updating any binded template content ({{thing}}, etc)
      // $watch updates the template itself so we can change the template on the fly
      scope.$watch(attrs.bindCompile, function(newTemplateString){
        // TODO if newTemplateString is type Number the program will crash
        // are there other edgecaes? how do we handle? test?
        if (newTemplateString) {
          // newTemplateString might be coming from a database and look something like ... 'I am not happy.'
          // which will throw an error when sent through angular.element (the period might be a selector?)
          // TODO create a test case demonstrating that 'I am not happy.' will be trated at plain text
          try {
            var compiledHTML = ($compile(newTemplateString)(compileScope));
            // To support plaintext templates we check the HTML object for
            // element count, and if 0, assume we're dealing with plaintext
            if (compiledHTML.length) {
              element.html(compiledHTML);
            } else {
              element.text(newTemplateString);
            };
          } catch (e) {
            // The catch strategy is to assume we're dealing with plaintext
            element.text(newTemplateString);
          }
        };
      });
    }
  };
}]);
