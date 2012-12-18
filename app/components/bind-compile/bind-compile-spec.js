describe('bind-compile', function(){
  var scope, el;



  beforeEach(module('bindCompile'));

  beforeEach(inject(function($rootScope, $compile) {
    var scenarioTemplateString  = '<div bind-compile="compileMe"></div>';
    var scenarioElement         = angular.element(scenarioTemplateString);
    scope = $rootScope;

    el = $compile(scenarioElement)(scope);
    scope.$digest();
  }));



  it('should allow plaintext by sending it to the html text method', function(){
    scope.$apply(function(){
      scope.compileMe = "PLAINTEXT";
    });
    expect(el.text()).toBe(scope.compileMe);
  });

  it('should allow html', function(){
    scope.$apply(function(){
      scope.compileMe = '<h1>Hi</h1>';
    });
    expect(el.html()).toBe('<h1 class="ng-scope">Hi</h1>');
  });

  it('should process embeded bindings', function(){
    scope.$apply(function(){
      scope.message   = 'Hi';
      scope.compileMe = '<h1>{{message}}</h1>';
    });
    expect(el.html()).toBe('<h1 class="ng-scope ng-binding">Hi</h1>');
  });

  it('should compile embeded directives', function(){
    scope.$apply(function(){
      scope.greetings = ['HI', 'HELLO', 'WELCOME'];
      scope.compileMe = '<ul><li ng-repeat="greeting in greetings">{{greeting}}</li></ul>';
    });
    expect(el.html()).toBe(
      '<ul class="ng-scope">'+
        '<!-- ngRepeat: greeting in greetings -->'+
        '<li ng-repeat="greeting in greetings" class="ng-scope ng-binding">'+
          'HI'+
        '</li>'+
        '<li ng-repeat="greeting in greetings" class="ng-scope ng-binding">'+
          'HELLO'+
        '</li>'+
        '<li ng-repeat="greeting in greetings" class="ng-scope ng-binding">'+
          'WELCOME'+
        '</li>'+
      '</ul>'
      );
  });

});
