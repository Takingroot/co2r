(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    definition(module.exports, localRequire(name), module);
    var exports = cache[name] = module.exports;
    return exports;
  };

  var require = function(name) {
    var path = expand(name, '.');

    if (has(cache, path)) return cache[path];
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex];
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '"');
  };

  var define = function(bundle) {
    for (var key in bundle) {
      if (has(bundle, key)) {
        modules[key] = bundle[key];
      }
    }
  }

  globals.require = require;
  globals.require.define = define;
  globals.require.brunch = true;
})();

window.require.define({"init": function(exports, require, module) {
  require('./locales');
  require('./scripts/app-data');
  require('./scripts/app');
  $(function(){
    return $.getJSON('http://co2r-data-staging.herokuapp.com/api/app').success(function(adminedAppData){
      import$(app_data, adminedAppData);
      return angular.bootstrap(document.documentElement, ['co2r']);
    });
  });
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}});

window.require.define({"locales": function(exports, require, module) {
  window.app_locales = {};
  app_locales.en = {
    can_do: {
      feedback: {
        title: "Give us feedback",
        description: "<p>lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      },
      spread_word: {
        title: "Spread the word",
        description: "<p>lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      },
      recruit_company: {
        title: "Recruit a company",
        description: "<p>lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      },
      sponsor_co2r: {
        title: "Sponsor us",
        description: "<p>lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      }
    },
    co2r: "CO2R",
    shoot: "Shoot",
    our_mission: "Our mission",
    faq: "FAQ",
    register_your_product: "Register your product",
    other_things_you_can_do: "Other things you can do to help",
    give_us_feedback: "Give us feedback",
    feedback_message_prompt: "Idea? Complaint? Praise? Question?",
    learn_more_about_co2r: "Learn more about the CO2R platform",
    learn_more: "Learn More",
    trees_planted: "%s Trees planted",
    email: "Email",
    phone: "Phone",
    inquire: "Inquire",
    name_or_organization: "Name/Organization",
    your_message: "Your message",
    register_introduction: "Contact us about your product or just drop us a line. We're interested in hearing from you whether your're an experienced green company or just venturing out. We can answer your questions and get you going.",
    introduction_title: "CO<sub>2</sub> Responsible",
    introduction_text: "<p class=\"lead\">\n  We help companies be responsble about the\n  <span co2r-definition>carbon</span>\n  their products emit into the atmosphere. We achieve this by planting enough trees in Nicaragua to negate their emissions.\n</p>\n<p>Sed ut perspiciatis unde omnis iste natus error [Taking Root] sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo.</p>",
    directory: {
      filter_input_prompt: 'Filter CO2 responsible products by name'
    },
    artifact: {
      download_report: "Download the %s report",
      business_card_contact_lead_in: "Get in touch:",
      offset_since: "Offset since %s",
      reports_section_title: "Footprint Summary Reports",
      report_section_titles: {
        other_eco_actions: 'Other environmental actions',
        total_vs_offset: 'Total <span class="co2-keyword">CO<sub>2</sub></span> produced and total <span class="co2-keyword">CO<sub>2</sub></span> offset',
        co2_sources: '%s sources',
        co2_per_thing_made: '%s for %s'
      }
    },
    about: {
      tab_label_map: "Map",
      tab_label_video: "Video",
      topic_1: {
        title: "Ecosystems",
        text: "<p class=\"lead\"> One of the three main aims of Taking Root's project is to protect and restore ecosystems through reforestation. Here are some of the ways this is done.</p>\n<h5>Preserving ecosystems</h5>\n<p> Forest preservation: In order to protect other forests from being cut down for farmland, Taking Root only reforests land that isn't being used. Also, specific trees are planted for the farmers to use as firewood and timber.</p>\n<p> Air quality: Trees improve air quality by retaining humidity, absorbing carbon and producing oxygen.</p>\n<p> Waterways: The trees help capture water in the dry season and minimize flooding and landslides in the rainy season. They also help regulate the water that flows into the nearby Estero Real, one of Central America's most important estuaries in terms of biodiversity.</p>"
      },
      topic_2: {
        title: "Livlihoods",
        text: "<p class=\"lead\"> A second core aim of the project is to improve the livelihoods of the participating community members through reforestation.</p>\n<h5> Improving livelihoods</h5>\n<p> With over 136 small-scale farmers in 21 communities as of 2012 working to reforest underutilized parts of their land, there are a lot of people involved in every step of the process. Among other things, participants help select the tree species, gather seeds, build nurseries, plant trees, and protect them as they grow.</p>\n<p> Incentives are put into place to encourage participation and help farmers at each step of the project.</p>\n<p> Interest-free loans: Taking Root provides interest-free loans to help farmers build fencing, clear shrubs and plant the seedlings. This in turn generates many jobs within the community.</p>"
      },
      topic_3: {
        title: "Climate Change",
        text: "<p class=\"lead\">The third core aim of the project is to use social reforestation to tackle climate change, a serious global issue that must be addressed.</p>\n<h5>Mitigating climate change</h5>\n<p>Preventing emissions: Deforestation accounts for over 17% of global CO2 emissions - almost as much as all the cars, trucks, boats and planes on the planet combined! By working with communities to preserve forests and prevent further destruction, Taking Root is reducing the amount of CO2 released into the atmosphere.</p>\n<p>Effective carbon pumps: Since about half of a tree's dry weight is made of carbon, trees serves as pumps, pulling CO2 out of the air and storing it in their plant tissue. Closer to the equator, these trees can grow up to 10 times faster than in northern climates.</p>"
      },
      community_title: "The Limay Community Carbon Project",
      community_text: "<p> The Limay Community Carbon Project is a community-based reforestation initiative that works with small-scale farming families in Nicaragua to restore ecosystems, improve livelihoods and tackle climate change.</p>\n<p> The project is developed according to the [Plan Vivo Standard], a system that offers incentives to farmers who agree to manage their land in a way that provides an ecological service, such as planting and maintaining trees to absorb carbon.</p>\n<p> The Limay Community Carbon Project is developed by [Taking Root], a non-profit organization, based in Montreal (Canada).</p>"
    },
    sponsor_name: "Caisse d'economie solidaire",
    sponsor_description: "Réalisé avec la participation financière de la Caisse d’économie solidaire Desjardins, qui contribue à bâtir un Québec plus juste dans la perspective d’un développement durable.",
    sponsor_link: "http://www.caissesolidaire.coop",
    taking_root: "Taking root",
    taking_root_description: "lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et doloremn.",
    colofon: "Colofon: Site design and frontend development by\n<a href=\"http://www.jaosnkuhrt.com\">Jason kuhrt</a>.\nAPI and backend development by\n<a> Pierre Drescher</a>.\nTools used:\n<a href=\"http://angularjs.org\">Angularjs</a>,\n<a href=\"http://meteor.com\">Meteor</a>,\n<a href=\"http://meteor.com\">Django</a>.\n<a href=\"http://Heroku.com\">Heroku</a>."
  };
}});

window.require.define({"scripts/app-data": function(exports, require, module) {
  window.app_data = {
    partialsPath: "/partials"
  };
  app_data.other_things_you_can_do = [
    {
      label: "can_do.feedback.title",
      description: 'can_do.feedback.description',
      templateName: 'can-do-feedback'
    }, {
      label: "can_do.sponsor_co2r.title",
      description: 'can_do.sponsor_co2r.description',
      templateName: 'can-do-sponsor_co2r'
    }, {
      label: "can_do.recruit_company.title",
      description: 'can_do.recruit_company.description',
      templateName: 'can-do-recruit_company'
    }, {
      slug: "spread_word",
      label: "can_do.spread_word.title",
      description: 'can_do.spread_word.description',
      templateName: 'can-do-spread-word'
    }
  ];
  app_data.default_user_preferences = {
    show_introduction: true,
    locale: 'en'
  };
  app_data.urls = {
    logo: "http://co2r.com/images/co2_emblem_service.gif",
    introduction_figure: "http://upload.wikimedia.org/wikipedia/commons/c/c0/Blank.gif"
  };
  app_data.defaults = {
    co2_per_thing_made_unit: 'kg'
  };
  app_data.expansions = {
    co2: '<span class="co2-keyword">CO<sub>2</sub></span>'
  };
}});

window.require.define({"scripts/app": function(exports, require, module) {
  require('./services');
  require('./filters');
  require('./controllers');
  require('./directives');
  window.CO2R = angular.module('co2r', ['ngSanitize', 'ui', 'co2r.services', 'co2r.filters', 'co2r.controllers', 'co2r.directives']);
  CO2R.config([
    '$locationProvider', function($locationProvider){
      return $locationProvider.html5Mode(true);
    }
  ]);
  require('./routes');
  CO2R.run(function($rootScope, preferencesStorage, $location, $locale, $http, partialPath){
    var navItems;
    navItems = [
      {
        label: "co2r",
        url: "directory"
      }, {
        label: "our_mission",
        url: "about"
      }, {
        label: "faq",
        url: "faq"
      }, {
        label: "register_your_product",
        url: "/register-your-product"
      }, {
        label: "other_things_you_can_do",
        url: "/other-things-you-can-do-to-help"
      }
    ];
    $rootScope.partialPath = partialPath;
    $rootScope.navs = {
      primary: function(){
        return _.filter(navItems, function(it){
          return _.contains(['co2r', 'our_mission', 'faq'], it.label);
        });
      }(),
      callout: function(){
        return _.filter(navItems, function(it){
          return _.contains(['register_your_product', 'other_things_you_can_do'], it.label);
        });
      }(),
      footer: navItems
    };
    $rootScope.app_title = "CO2R";
    $rootScope.preferences = preferencesStorage;
    $rootScope.count_offsets = function(co2_amount){
      return co2_amount / app_data.calculation_variables.offsets_per_co2_ton;
    };
    $rootScope.app_data = app_data;
    $rootScope.$on("$routeChangeSuccess", function(e, route, previous_route){
      var get_url;
      get_url = function(){
        var path;
        path = $location.path();
        if (path === "/") {
          return 'directory';
        } else {
          return path;
        }
      };
      return $rootScope.appCssClasses = _.union(_.keys(route.pathParams), _.values(route.pathParams), _.str.cssClassify(get_url()).split(" "));
    });
    return $rootScope.e = function(key){
      return app_data.expansions[key];
    };
  });
}});

window.require.define({"scripts/controllers/about": function(exports, require, module) {
  module.exports = function($scope){
    $scope.$root.page_title = "About";
    $scope.mapOptions = {
      center: new google.maps.LatLng(13.1667, -86.6167),
      zoom: 15,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    return $scope.$watch('treeplantingMap', function(){
      return new google.maps.KmlLayer('http://thievishfilms.s3.amazonaws.com/lccp-2012-en.kml', {
        map: $scope.treeplantingMap
      });
    });
  };
}});

window.require.define({"scripts/controllers/artifact": function(exports, require, module) {
  module.exports = function($scope, $routeParams, $http){
    return $http.get("http://co2r-data-staging.herokuapp.com/api/artifact/" + $routeParams.artifact).success(function(data){
      var ref$;
      $scope.artifact = data.artifact;
      $scope.reports = _.sortBy($scope.artifact.footprints, function(it){
        return it.year;
      });
      $scope.latestReport = (ref$ = $scope.reports)[ref$.length - 1];
      $scope.column_width = 300;
      $scope.timeline_width = $scope.column_width * $scope.reports.length;
      _.each($scope.reports, function(report){
        var varsForYear, offsetCount, treesPlanted;
        varsForYear = _.first(_.select(app_data.offset_variables, function(it){
          return it.year === report.year;
        }));
        if (!varsForYear) {
          throw "There is no offset-variables data for " + report.year;
        }
        offsetCount = report.total_offset_tons * varsForYear.offsets_per_co2_ton;
        treesPlanted = offsetCount * varsForYear.trees_per_offset;
        return report.trees_planted = treesPlanted.floor();
      });
      $scope.data = {
        co2_sources: _.filter(_.pluck($scope.reports, 'carbon_sources_list'), function(it){
          return it.length;
        }),
        co2_per_thing_made: _.sortBy(_.pluck($scope.reports, 'co2_per_unit'), function(it){
          return -1 * it;
        }),
        total_co2_vs_offset: {
          total_co2: _.pluck($scope.reports, 'total_tons_produced'),
          offset_co2: _.pluck($scope.reports, 'total_offset_tons')
        }
      };
      return $scope.hasOtherActions = _.filter(_.pluck($scope.reports, 'other_actions'), function(it){
        return it.length;
      }).length > 0;
    });
  };
}});

window.require.define({"scripts/controllers/directory": function(exports, require, module) {
  module.exports = function($scope, $http){
    $scope.$root.page_title = 'Directory';
    return $http.get('http://co2r-data-staging.herokuapp.com/api/artifacts').success(function(data){
      return $scope.artifacts = data.artifacts;
    });
  };
}});

window.require.define({"scripts/controllers/faq": function(exports, require, module) {
  module.exports = function($scope, $http){
    return $http.get('http://co2r-data-staging.herokuapp.com/api/faqs').success(function(data){
      return $scope.faqs = data.faqs;
    });
  };
}});

window.require.define({"scripts/controllers/index": function(exports, require, module) {
  angular.module('co2r.controllers', []).controller('about', require('./about')).controller('artifact', require('./artifact')).controller('directory', require('./directory')).controller('faq', require('./faq')).controller('other-things', require('./other-things')).controller('register', require('./register')).controller('test', require('./test'));
}});

window.require.define({"scripts/controllers/other-things": function(exports, require, module) {
  module.exports = function(){};
}});

window.require.define({"scripts/controllers/register": function(exports, require, module) {
  module.exports = function(){};
}});

window.require.define({"scripts/controllers/test": function(exports, require, module) {
  module.exports = function(){};
}});

window.require.define({"scripts/directives/anchorable": function(exports, require, module) {
  module.exports = function($anchorScroll){
    return function(scope, el, attrs){
      return attrs.$observe(attrs.id, function(){
        return $anchorScroll();
      });
    };
  };
}});

window.require.define({"scripts/directives/bootstrap/carousel": function(exports, require, module) {
  module.exports = function(m){
    m.directive('carousel', function(){
      return {
        restrict: 'E',
        transclude: true,
        replace: true,
        controller: function($element){
          this.slides = [];
          return this.registerSlide = function(newSlide){
            this.slides.push(newSlide);
            return $element.carousel();
          };
        },
        template: "<div class=\"carousel\" ng-transclude>\n</div>"
      };
    });
    return m.directive('carouselItem', function(){
      return {
        restrict: 'E',
        require: '^carousel',
        transclude: true,
        replace: true,
        template: "<div class=\"item\">\n  <img ng-src=\"{{src}}\">\n  <div class=\"carousel-caption\", ui-if=\"caption\", ng-bind-html=\"caption\"></div>\n</div>",
        link: function(scope, el, attrs, carousel){
          scope.caption = scope.$eval(attrs.caption);
          scope.src = scope.$eval(attrs.src);
          return carousel.registerSlide(el);
        }
      };
    });
  };
}});

window.require.define({"scripts/directives/bootstrap/index": function(exports, require, module) {
  module.exports = function(m){
    require('./carousel')(m);
    require('./popover')(m);
    require('./spyscrollable')(m);
    require('./tab')(m);
    return require('./tooltip')(m);
  };
}});

window.require.define({"scripts/directives/bootstrap/popover": function(exports, require, module) {
  module.exports = function(m){
    return m.directive('popover', function($http, $compile, $interpolate){
      return function(scope, el, attrs){
        var popoverConfig;
        popoverConfig = scope.$eval(attrs.popover);
        if ('contentSrc' in popoverConfig) {
          $http.get(popoverConfig.contentSrc).success(function(templateString){
            popoverConfig.content = $compile(templateString)(scope);
            el.popover(popoverConfig);
            return prepareTeardown();
          });
        } else {
          popoverConfig.content = $compile(popoverConfig.content)(scope);
          el.popover(popoverConfig);
          prepareTeardown();
        }
        function prepareTeardown(){
          var popover, this$ = this;
          popover = el.data('popover');
          return scope.$on('$destroy', function(){
            return popover.destroy();
          });
        }
        return prepareTeardown;
      };
    });
  };
}});

window.require.define({"scripts/directives/bootstrap/spyscrollable": function(exports, require, module) {
  module.exports = function(m){
    return m.directive('spyscrollable', function($anchorScroll){
      return function(scope, el, attrs){
        return attrs.$observe(attrs.id, function(){
          $anchorScroll();
          return $(document.body).scrollspy('refresh');
        });
      };
    });
  };
}});

window.require.define({"scripts/directives/bootstrap/tab": function(exports, require, module) {
  module.exports = function(m){
    return m.directive('tab', function(){
      return function(scope, el, attrs){
        return el.click(function(e){
          e.preventDefault();
          return $(this).tab('show');
        });
      };
    });
  };
}});

window.require.define({"scripts/directives/bootstrap/tooltip": function(exports, require, module) {
  module.exports = function(m){
    return m.directive('tooltip', function(){
      return function(scope, el, attrs){
        var config, tooltip, this$ = this;
        config = maybeEval(attrs.tooltip);
        el.tooltip(typeof config === 'string' ? {
          title: config
        } : config);
        tooltip = el.data('tooltip');
        scope.$on('$destroy', function(){
          return tooltip.destroy();
        });
        function maybeEval(attrVal){
          return scope.$eval(attrVal) || attrVal;
        }
        return maybeEval;
      };
    });
  };
}});

window.require.define({"scripts/directives/charts/chart-co2-per-unit": function(exports, require, module) {
  CO2R.directive('chartCo2PerUnit', function(){
    return {
      restrict: 'E',
      replace: true,
      template: "<svg style='display:block' class='bar-chart'></svg>",
      link: function(scope, el, attrs){
        return attrs.$observe('data', function(){
          var boxWidth, data, chartHeight, gutter, chartWidth, barWidth, y, chart;
          boxWidth = scope.$eval(attrs.columnWidth);
          data = _.invoke(_.map(scope.$eval(attrs.data), function(item){
            return item * 100;
          }), 'round', 2);
          chartHeight = 200;
          gutter = 140;
          chartWidth = data.length * boxWidth;
          barWidth = boxWidth - gutter;
          y = d3.scale.linear().domain([0, d3.max(data)]).range([0, chartHeight]);
          return chart = d3.select(el[0]).style('height', chartHeight).style('width', chartWidth + "px").selectAll('rect').data(data).enter().append('rect').attr('x', function(d, i){
            return boxWidth * i + gutter / 2;
          }).attr('y', function(d, i){
            return chartHeight - y(d).round();
          }).attr('height', function(d){
            return y(d).round();
          }).attr('width', barWidth).attr('fill', 'red');
        });
      }
    };
  });
}});

window.require.define({"scripts/directives/charts/chart-co2-sources-legend": function(exports, require, module) {
  CO2R.directive('chartCo2SourcesLegend', function(){
    return {
      restrict: 'E',
      replace: true,
      template: "<div class='row h-gutters-2'></div>",
      link: function(scope, el, attrs){
        return attrs.$observe('data', function(){
          var vis_data, color, vis, pie, x$;
          vis_data = scope.$eval(attrs.data);
          color = d3.scale.category20c();
          vis = d3.select(el[0]).data([vis_data]);
          pie = d3.layout.pie().value(function(d, i){
            return d.percent;
          });
          return (x$ = vis.selectAll('.slice-label').data(pie).enter().append('div'), x$.attr('class', function(d, i){
            return "row h-gutters-5 slice-label label-for-data-" + _.str.slugify(vis_data[i].name);
          }), x$.append('div').style('background-color', function(d, i){
            return color(i);
          }).style('width', '10px').style('height', '10px').style('margin-right', '5px').style('margin-top', '6px'), x$.append('div').text(function(d, i){
            return vis_data[i].name;
          }).style('text-transform', 'capitalize'));
        });
      }
    };
  });
}});

window.require.define({"scripts/directives/charts/chart-co2-sources": function(exports, require, module) {
  
  CO2R.directive('chartCo2Sources', function() {
    return {
      restrict: "E",
      replace: true,
      template: "<svg style='display:block;' class='pie-chart'></svg>",
      link: function(scope, el, attrs) {
        return attrs.$observe('data', function() {
          var arc, arcs, box_height, box_width, color, gutter, pie, vis, vis_data, vis_height, vis_radius, vis_width;
          vis_data = scope.$eval(attrs.data);
          gutter = 80;
          box_width = scope.$eval(attrs.columnWidth);
          box_height = box_width;
          vis_width = box_width - gutter;
          vis_height = vis_width;
          vis_radius = vis_width / 2;
          color = d3.scale.category20c();
          vis = d3.select(el[0]).data([vis_data]).style('width', "" + box_width + "px").style('height', "" + box_height + "px").style('margin', '0 auto').append('g').attr('transform', "translate(" + (vis_radius + gutter / 2) + "," + vis_radius + ")");
          arc = d3.svg.arc().outerRadius(vis_radius);
          pie = d3.layout.pie().value(function(d, i) {
            return d.percent;
          });
          arcs = vis.selectAll('.slice').data(pie).enter().append('g').attr('class', 'slice').attr('class', function(d, i) {
            return "slice-for-data-" + (_.str.slugify(vis_data[i].name));
          });
          arcs.append('path').attr('fill', function(d, i) {
            return color(i);
          }).attr('d', arc);
          return arcs.append('text').attr('transform', function(d, i) {
            d.innerRadius = d.outerRadius = 0;
            return "translate(" + (arc.centroid(d)) + ")";
          }).attr('text-anchor', 'middle').text(function(d, i) {
            if (0 !== vis_data[i].percent) {
              return (100 * vis_data[i].percent).round(1) + '%';
            } else {
              return '';
            }
          }).style('fill', 'white');
        });
      }
    };
  });
  
}});

window.require.define({"scripts/directives/charts/chart-total-co2": function(exports, require, module) {
  CO2R.directive('chartTotalCo2VsOffset', function(){
    return {
      restrict: 'E',
      replace: true,
      template: "<svg style='display:block' class='bar-chart'></svg>",
      link: function(scope, el, attrs){
        return attrs.$observe('data', function(){
          var boxWidth, data, chartHeight, gutter, chartWidth, barWidth, chart, totalCo2Y, offsetCo2Y;
          boxWidth = scope.$eval(attrs.columnWidth);
          data = scope.$eval(attrs.data);
          chartHeight = 200;
          gutter = 200;
          chartWidth = data.total_co2.length * boxWidth;
          barWidth = boxWidth - gutter;
          chart = d3.select(el[0]).style('height', chartHeight).style('width', chartWidth + "px");
          totalCo2Y = d3.scale.linear().domain([0, d3.max(data.total_co2)]).range([0, chartHeight]);
          chart.selectAll('.total-co2-bar').data(data.total_co2).enter().append('rect').classed('total-co2-bar', true).attr('x', function(d, i){
            return Math.round(boxWidth * i + gutter / 4.5);
          }).attr('y', function(d, i){
            return chartHeight - totalCo2Y(d);
          }).attr('height', totalCo2Y).attr('width', barWidth);
          offsetCo2Y = d3.scale.linear().domain([0, d3.max(data.offset_co2)]).range([0, chartHeight]);
          return chart.selectAll('.offset-co2-bar').data(data.offset_co2).enter().append('rect').classed('offset-co2-bar', true).attr('x', function(d, i){
            return Math.round(boxWidth * i + gutter - gutter / 4.5);
          }).attr('y', function(d, i){
            return 0;
          }).attr('height', offsetCo2Y).attr('width', barWidth);
        });
      }
    };
  });
}});

window.require.define({"scripts/directives/co2-contrasted": function(exports, require, module) {
  module.exports = function(partialPath){
    return {
      restrict: "E",
      transclude: true,
      replace: true,
      scope: true,
      template: "<span class=\"co2-keyword co2-contrasted\" popover=\"{contentSrc: popoverContentPartialName, trigger: 'hover'}\">\n  {{amount | unit:amountUnit}}\n</span>",
      link: function(scope, el, attrs){
        scope.popoverContentPartialName = partialPath('list-co2-comparisons');
        scope.amountUnit = 'unit' in attrs
          ? scope.$eval(attrs.unit)
          : app_data.defaults.co2_per_thing_made_unit;
        return scope.amount = scope.$eval(attrs.amount);
      }
    };
  };
}});

window.require.define({"scripts/directives/co2r-bind": function(exports, require, module) {
  module.exports = function($compile){
    return function(scope, el, attrs){
      var evaled;
      evaled = scope.$eval(attrs.co2rBind);
      if (evaled[0] !== '<') {
        return el.html(evaled);
      } else {
        return el.html($compile(evaled, attrs.co2rBind)(scope));
      }
    };
  };
}});

window.require.define({"scripts/directives/co2r-definition": function(exports, require, module) {
  module.exports = function(){
    return {
      replace: true,
      transclude: true,
      template: "<a class=\"co2r-definition\" popover=\"popoverConfig\" ng-transclude></a>",
      link: function(scope, el, attrs){
        return scope.popoverConfig = _.find(scope.app_data.defined_terms, function(it){
          return it.term_name === el.text();
        });
      }
    };
  };
}});

window.require.define({"scripts/directives/index": function(exports, require, module) {
  var m;
  m = angular.module('co2r.directives', []).directive('anchorable', require('./anchorable')).directive('co2Contrasted', require('./co2-contrasted')).directive('co2rBind', require('./co2r-bind')).directive('co2rDefinition', require('./co2r-definition')).directive('isotope', require('./isotope')).directive('isotopeItem', require('./isotope-item')).directive('navList', require('./navigation')).directive('scrollFixBottom', require('./scroll-fix-bottom')).directive('smoothScroll', require('./smooth-scroll')).directive('timelineConductor', require('./timeline-conductor')).directive('timelineSlider', require('./timeline-slider')).directive('anchorable', require('./anchorable'));
  require('./bootstrap')(m);
}});

window.require.define({"scripts/directives/isotope-item": function(exports, require, module) {
  module.exports = function(){
    return {
      require: '^isotope',
      link: function(scope, el, attrs, containerEl){
        return containerEl.reg(el);
      }
    };
  };
}});

window.require.define({"scripts/directives/isotope": function(exports, require, module) {
  module.exports = function($parse){
    return {
      controller: function($element){
        var exec;
        this.items = [];
        this.reg = function(itemEl){
          return this.items.push(itemEl);
        };
        exec = function(){
          $element.removeClass('hidden');
          return $element.isotope({
            layoutMode: 'masonry'
          });
        };
        return setTimeout(exec, 1500);
      },
      link: function(scope, el, attrs){
        return scope.isotopeFilterByName = function(name){
          name == null && (name = '');
          return el.isotope({
            filter: "[data-name*='" + name.toLowerCase() + "']"
          });
        };
      }
    };
  };
}});

window.require.define({"scripts/directives/navigation": function(exports, require, module) {
  module.exports = function(){
    return {
      scope: {
        items: '='
      },
      restrict: 'AE',
      transclude: true,
      replace: true,
      template: "<ul class=\"nav\" ng-transclude>\n  <li class=\"{{navItem.label | slugify}}\" ng-repeat=\"navItem in items\">\n    <a href=\"{{navItem.url}}\">{{navItem.label | i18n}}</a>\n  </li>\n</ul>"
    };
  };
}});

window.require.define({"scripts/directives/scroll-fix-bottom": function(exports, require, module) {
  module.exports = function($timeout){
    return function(scope, el, attrs){
      var className, fixEl;
      className = 'scrolled-to';
      fixEl = $(attrs.scrollFixBottom);
      refreshScrolledToState();
      scope.$root.$on('$routeChangeSuccess', function(){
        return $timeout(refreshScrolledToState, 0);
      });
      $(window).scroll(refreshScrolledToState);
      $(window).resize(refreshScrolledToState);
      function refreshScrolledToState(){
        var atY, targetY;
        atY = $(window).height() + $(window).scrollTop();
        targetY = el.offset().top;
        return fixEl.toggleClass(className, atY >= targetY);
      }
      return refreshScrolledToState;
    };
  };
}});

window.require.define({"scripts/directives/smooth-scroll": function(exports, require, module) {
  module.exports = function($location){
    return function(scope, el, attrs){
      var $body;
      $body = $(document.body);
      return attrs.$observe('href', function(){
        return el.click(function(e){
          var ref$, yPos;
          yPos = (ref$ = $(attrs.href).offset()) != null ? ref$.top : void 8;
          if (yPos != null) {
            $body.animate({
              scrollTop: yPos
            }, 'fast');
            return false;
          }
        });
      });
    };
  };
}});

window.require.define({"scripts/directives/timeline-conductor": function(exports, require, module) {
  
  module.exports = function() {
    return {
      restrict: "E",
      replace: true,
      transclude: true,
      controller: function($scope) {
        $scope.slider = $();
        return this.register_slider = function(new_slider) {
          return $scope.slider = $scope.slider.add(new_slider);
        };
      },
      template: "<div class='timeline-conductor' ng-transclude></div>",
      link: function(scope, el, attrs) {
        var at_timeline_end, at_timeline_start, c_index, column_count, column_width, conductor, is_in_index_range, is_in_visual_bounds, last_index, most_recent_index_that_can_be_seeked, normalize_index, restrict_index_to_bounds, visually_restrict_index_to_conductor;
        conductor = el;
        c_index = 0;
        column_count = void 0;
        column_width = void 0;
        attrs.$observe('columnCount', function() {
          column_count = scope.$eval(attrs.columnCount);
          column_width = scope.$eval(attrs.columnWidth);
          c_index = 0;
          return scope.move_timeline(c_index);
        });
        $(window).resize(function() {
          scope.$apply();
          return auto_shift();
        });
        window.move_timeline = scope.move_timeline = function(to_index) {
          var new_index;
          new_index = visually_restrict_index_to_conductor(restrict_index_to_bounds(normalize_index(to_index)));
          c_index = new_index;
          return scope.slider.css('margin-left', position_for_index(new_index) || '');
        };
        window.auto_shift = function() {
          if (!at_timeline_end()) {
            return scope.move_timeline("+" + (enough_room_for_how_many_columns()));
          }
        };
        visually_restrict_index_to_conductor = function(to_index) {
          if (!is_in_visual_bounds(to_index)) {
            return most_recent_index_that_can_be_seeked();
          } else {
            return to_index;
          }
        };
        is_in_index_range = function(to_index) {
          return (last_index() >= to_index && to_index >= 0);
        };
        is_in_visual_bounds = function(to_index) {
          return to_index >= most_recent_index_that_can_be_seeked();
        };
        most_recent_index_that_can_be_seeked = function() {
          var re;
          re = Math.floor(conductor.width() / column_width) - 1;
          return re;
        };
        window.enough_room_for_how_many_columns = function() {
          var available_width, enough_room_for_columns, slider_width_on_left_side;
          slider_width_on_left_side = function() {
            return (c_index + 1) * column_width;
          };
          available_width = conductor.width() - slider_width_on_left_side();
          enough_room_for_columns = available_width > 0 ? Math.floor(available_width / column_width) : 0;
          return enough_room_for_columns;
        };
        last_index = function() {
          return column_count - 1;
        };
        at_timeline_start = function() {
          return c_index === 0;
        };
        window.position_for_index = function(index) {
          var pos_x;
          pos_x = -1 * (last_index() - index) * column_width;
          return pos_x;
        };
        at_timeline_end = function() {
          return c_index === last_index();
        };
        window.can_move_timeline = scope.can_move_timeline = function(to_index_) {
          var conductor_width, slider_width, to_index;
          slider_width = scope.slider.width();
          conductor_width = conductor.width();
          if (slider_width < conductor_width) {
            return false;
          }
          to_index = normalize_index(to_index_);
          return is_in_visual_bounds(to_index) && is_in_index_range(to_index);
        };
        restrict_index_to_bounds = function(index) {
          if (index < 0) {
            return 0;
          }
          if (index > last_index()) {
            return last_index();
          } else {
            return index;
          }
        };
        return normalize_index = function(direction_) {
          var delta_index, direction;
          if (angular.isString(direction_)) {
            direction = direction_[0];
            delta_index = parseInt(direction_.substring(1));
            switch (direction) {
              case "-":
                return c_index - delta_index;
              case "+":
                return c_index + delta_index;
            }
          } else {
            return direction_;
          }
        };
      }
    };
  };
  
}});

window.require.define({"scripts/directives/timeline-slider": function(exports, require, module) {
  module.exports = function(){
    return {
      restrict: 'E',
      require: '^timelineConductor',
      transclude: true,
      replace: true,
      template: "<div class=\"timeline-slider-window\" style='overflow:hidden'>\n  <div class=\"timeline-slider align-center\" ng-transclude></div>\n</div>",
      link: function(scope, el, attrs, timeline){
        return timeline.register_slider(el.children('.timeline-slider'));
      }
    };
  };
}});

window.require.define({"scripts/filters/index": function(exports, require, module) {
  var slice$ = [].slice;
  angular.module('co2r.filters', []).filter('unit', function(){
    return function(amount, requestedUnitType){
      var unitTypes, unitTypeFn;
      unitTypes = {
        t: function(it){
          return it + " t";
        },
        kg: function(it){
          return it * 1000 + " kg";
        }
      };
      unitTypeFn = unitTypes[requestedUnitType];
      if (!unitTypeFn) {
        throw "The unit type '" + requestedUnitType + "' is not supported on CO2R. You are limited to: " + _.keys(unitTypes) + ".";
      } else {
        return unitTypeFn(amount);
      }
    };
  }).filter('to_icon_name', function(){
    return function(keyword){
      var ref$;
      return (ref$ = {
        email: 'envelope'
      }[keyword]) != null ? ref$ : keyword;
    };
  }).filter('slugify', function(){
    return function(it){
      return _.str.slugify(it);
    };
  }).filter('prefixMailto', function(){
    return function(string, linkType){
      switch (false) {
      case linkType !== 'email':
        return 'mailto:' + string;
      default:
        return string;
      }
    };
  }).filter('i18n', function($locale, preferencesStorage){
    return function(localeKey){
      var interpolations, getLocales, localizedString, ref$;
      interpolations = slice$.call(arguments, 1);
      getLocales = function(){
        var langCode;
        langCode = $locale.id.substring(0, $locale.id.indexOf('-'));
        if (langCode in app_locales) {
          return app_locales[langCode];
        } else {
          return app_locales[preferencesStorage.get('locale')];
        }
      };
      localizedString = _.traverse(getLocales(), localeKey);
      if (_.isEmpty(interpolations)) {
        return localizedString;
      } else {
        return (ref$ = _.str).sprintf.apply(ref$, [localizedString].concat(slice$.call(interpolations)));
      }
    };
  });
}});

window.require.define({"scripts/routes": function(exports, require, module) {
  CO2R.config(function($routeProvider, partialPath){
    $routeProvider.when('/', {
      templateUrl: partialPath('directory'),
      controller: 'directory'
    });
    $routeProvider.when('/directory', {
      templateUrl: partialPath('directory'),
      controller: 'directory'
    });
    $routeProvider.when('/about', {
      templateUrl: partialPath('about'),
      controller: 'about'
    });
    $routeProvider.when('/faq', {
      templateUrl: partialPath('faq'),
      controller: 'faq'
    });
    $routeProvider.when('/register-your-product', {
      templateUrl: partialPath('register'),
      controller: 'register'
    });
    $routeProvider.when('/other-things-you-can-do-to-help', {
      templateUrl: partialPath('other-things'),
      controller: 'other-things'
    });
    $routeProvider.when('/test', {
      templateUrl: partialPath('test'),
      controller: 'test'
    });
    return $routeProvider.when('/:artifact', {
      templateUrl: partialPath('artifact'),
      controller: 'artifact'
    });
  });
}});

window.require.define({"scripts/services/index": function(exports, require, module) {
  angular.module('co2r.services', []).factory('preferencesStorage', require('./preferences-storage')).constant('partialPath', require('./partial-path'));
}});

window.require.define({"scripts/services/partial-path": function(exports, require, module) {
  module.exports = function(partialName){
    return "/partials/" + partialName + ".html";
  };
}});

window.require.define({"scripts/services/preferences-storage": function(exports, require, module) {
  module.exports = function(){
    return new PreferencesStorage(app_data.default_user_preferences);
  };
}});

