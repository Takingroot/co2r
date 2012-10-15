window.require.define({"index": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<!DOCTYPE html><html><head><script>window.brunch = window.brunch || {}\nwindow.brunch[\'auto-reload\'] = {enabled: true}\n</script><link rel="stylesheet" href="/stylesheets/app.css"><script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyACK0sp5adiQxeaADP87y6y_tX16aBVXQU&amp;sensor=false"></script><script src="/javascripts/vendor.js"></script><script src="/javascripts/app.js"></script><script>require(\'init\')</script><title ng-bind="app_title + \' - \' + page_title"></title></head><body ng-class="appCssClasses" data-spy="scroll" data-target=".faq-table-of-contents"><div class="app-navbar row aligns-middle"><nav-list items="navs.primary" class="row h-gutters-1 aligns-middle"><li><a popover="{content_src: app_data.partialPath(\'form_feedback\'), placement:\'bottom\'}">{{ \'give_us_feedback\' | i18n}}</a></li></nav-list><nav-list style="white-space:nowrap;" items="navs.callout" class="row h-gutters-1 align-right"><li><button ng-click="preferences.restoreDefaults()" tooltip="{title:\'Restore preferences\', placement:\'left\'}" class="btn"><span class="icon-undo"></span></button></li></nav-list></div><div id="app-content" ng-view="ng-view"></div><footer class="app-footer group"><div class="spread-the-word"><div style="margin-left:20px;padding:15px 20px;-webkit-user-select:none;border-radius:3px 3px 0 0;" class="inner span-4 dark-theme"><div ng-click="is_open = !is_open" style="cursor:pointer;" class="handle"><h5 class="icon-share unspaced"> Spread the word</h5></div><form ng-show="is_open" style="margin-bottom:0;" class="v-push-2"><div style="font-size:2em;" class="select-outlet row h-gutters-05"><i class="icon-twitter"></i><i class="icon-facebook"></i><i class="icon-pinterest"></i><i class="icon-google-plus"></i></div><textarea placeholder="{{\'your_message\' | i18n }}" rows="4" class="span v-push-1">Visit CO2R.com, a platform of co2 responsible products.</textarea><div><button class="btn span">Spread CO2R Love</button></div></form></div></div><div scroll-fix-bottom=".spread-the-word" class="app-footer-content dark-theme row group span"><nav-list items="navs.footer" class="span-4"></nav-list><div class="row h-gutters-2 align-right"><div class="sponsors span-4"><a href="{{ \'sponsor_link\' | i18n }}" target="_blank"><h4 class="aligns-middle"><i class="icon-sign-blank"></i><span>{{ \'sponsor_name\' | i18n }}</span></h4></a><p> {{ \'sponsor_description\' | i18n }}</p></div><div class="company span-3"><a href="http://takingroot.org" target="_blank"><h4 class="aligns-middle"><i class="icon-globe"></i><span> {{ \'taking_root\' | i18n }}</span></h4></a><p>{{\'taking_root_description\' | i18n }}</p><div style="font-size:1.5em;" class="row h-gutters-05"><a href="mailto:info@takingroot.org" ui-jq="popover" title="test" data-content="moo" class="icon-envelope"></a><a href="https://twitter.com/takingroot" class="icon-twitter"></a><a href="http://www.facebook.com/TakingRoot?ref=ts" class="icon-facebook"></a></div></div></div><br><br><br><br><br><br><br></div></footer></body></html>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/about": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<div class="align-center v-push-3"><div style="height:200px;" class="a-image col-6 v-push-3"></div><div class="introduction-copy col-6"><h1 co2r-bind="\'introduction_title\' | i18n"></h1><div co2r-bind="\'introduction_text\' | i18n" class="introduction-text"></div></div></div><div class="align-center v-push-3"><div class="row"><section class="col-6"><h2><i style="position:absolute;left:-30px;" class="icon-globe"></i><div co2r-bind="\'about.community_title\' | i18n" class="community-title"></div></h2><div co2r-bind="\'about.community_text\' | i18n" class="community-text"></div></section><section class="farmers-short col-6"><div class="row aligns-middle h-gutters-05"><h2>Carbon farmers</h2><p><a> (see all 365)</a></p></div></section></div><div class="tabbable v-push-2"><ul style="margin-bottom:0;" class="nav nav-tabs"><li class="active"><a href="#tab-1" tab="tab"><i class="icon-map-marker"></i><span co2r-bind="\'about.tab_label_map\' | i18n"></span></a></li><li><a href="#tab-2" tab="tab"><i class="icon-facetime-video"></i><span co2r-bind="\'about.tab_label_video\' | i18n"></span></a></li></ul><div class="tab-content"><div id="tab-1" class="tab-pane active"><div id="map_canvas" style="width:100%;height:400px;" ui-map="treeplantingMap" ui-event="{\'map-click\': \'test($event)\'}" ui-options="mapOptions"></div></div><div id="tab-2" class="tab-pane"><div style="height:400px;" class="a-image">TODO Video</div></div></div><div class="row v-push-2"><div ng-repeat="num in [1,2,3]" class="col-4"><header><div style="height:200px" class="a-image"></div><h3 co2r-bind="\'about.topic_\'+num+\'.title\' | i18n" class="text-align-center"></h3></header><div co2r-bind="\'about.topic_\'+num+\'.text\' | i18n" class="text v-push-1"></div></div></div></div></div><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/artifact": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<div class="align-center v-push-3"><div ui-if="artifact.images.length" class="gallery span-10 group"><carousel style="min-height:380px;"><carousel-item ng-repeat="image in artifact.images" src="image.image_url" caption="image.caption" class="span-10"></carousel-item></carousel><div style="margin:20px 20px; 0 0" class="emissions-badge pin-right pin-top"><h4 class="unspaced">{{artifact.unit_quantity}}\n{{artifact.unit_verbose}}<br/><co2-contrasted amount="latestReport.co2_per_unit"></co2-contrasted></h4></div></div><section class="about v-push-2"><header><h1 ng-bind="artifact.name"></h1><h4 ng-bind="\'offset_since\' | i18n:artifact.offset_since"></h4></header><div class="row v-push-1"><div class="description col-6"><div ng-bind-html="artifact.description" class="story"></div><small><a href="/about" class="aligns-middle"><i class="icon-pushpin"></i><span> {{ \'learn_more_about_co2r\' | i18n }}</span></a></small></div><div class="col-4"><div class="business-card float-right"><div style="width:100px;height:100px;margin-bottom:10px;" class="avatar a-image"><a href="{{ artifact.organization.website_url }}"><img src="{{artifact.organization.image_url}}"/></a></div><div ui-if="artifact.organization.contact_infos.length &gt; 0" class="contact"><ul style="margin-left:-7px" class="row h-gutters-025 unstyled text-align-center"><li ng-repeat="contact_method in artifact.organization.contact_infos"><h3 style="line-height:0;" class="unspaced"><a href="{{contact_method.link | prefixMailto:contact_method.contact_type}}" class="icon-{{contact_method.contact_type | to_icon_name}}"></a></h3></li></ul></div></div></div></div></section></div><section ui-if="reports.length" class="reports v-push-5 span a-image"><header style="text-align:center;"><h1 ng-bind="\'artifact.reports_section_title\' | i18n"></h1></header><timeline-conductor style="white-space:nowrap;" column-width="column_width" column-count="artifact.reports.length" ui-scrollfix="+0"><section ui-scrollfix="+0" class="timeline-header span scrollfix-fixed"><div style="font-size:24px;height:30px;" class="timeline-navigation clearfix"><a style="margin-top:2px;" class="pull-left"><i ng-show="can_move_timeline(\'+1\')" style="margin-left:20px;" ng-click="move_timeline(\'+1\')" class="icon-arrow-left align-middle"></i></a><a style="margin-top:2px;" class="pull-right"><i ng-show="can_move_timeline(\'-1\')" style="margin-right:20px;" ng-click="move_timeline(\'-1\')" class="icon-arrow-right align-middle"></i></a></div><timeline-slider><div class="row"><h5 style="width:{{column_width}}px" ng-repeat="report in reports" class="unspaced a-image year text-align-center timeline-item">{{report.year}}</h5></div></timeline-slider></section><section class="report-section report-section-co2-per-unit"><report-header-basic><div ng-bind-html="\'artifact.report_section_titles.co2_per_thing_made\' | i18n:e(\'co2\'):(artifact.unit_quantity+\' \'+artifact.unit_verbose)"></div></report-header-basic><timeline-slider><chart-co2-per-unit column-width="column_width" data="data.co2_per_thing_made"></chart-co2-per-unit><div style="border-top:1px solid lightgrey" class="row text-align-center"><div style="width:{{column_width}}px" ng-repeat="report in reports" class="timeline-item"><h4><co2-contrasted amount="report.co2_per_unit"></co2-contrasted></h4></div></div></timeline-slider></section><section class="report-section report-section-total-vs-offset"><report-header-basic><div ng-bind-html="\'artifact.report_section_titles.total_vs_offset\' | i18n"></div></report-header-basic><timeline-slider><chart-total-co2-vs-offset column-width="column_width" data="data.total_co2_vs_offset"></chart-total-co2-vs-offset><div style="border-top:1px solid lightgrey" class="row"><div style="width:{{column_width}}px" ng-repeat="report in reports" class="timeline-item"><div style="margin-left:45px;" class="row text-aligns-center"><h4 style="width:100px;"><co2-contrasted amount="report.total_tons_produced" unit="\'t\'"></co2-contrasted></h4><h4 style="width:100px;margin-left:12px;"><co2-contrasted amount="-1 * report.total_offset_tons" unit="\'t\'"></co2-contrasted></h4></div><h6 style="margin-left:158px;width:100px;">{{ \'trees_planted\' | i18n:report.trees_planted }}</h6></div></div></timeline-slider></section><section ui-if="data.co2_sources.length" class="report-section report-section-co2-sources"><header class="report-header align-center"><h3 ng-bind-html="\'artifact.report_section_titles.co2_sources\' | i18n:e(\'co2\')" class="report-title text-align-center"></h3><chart-co2-sources-legend data="data.co2_sources[0]"></chart-co2-sources-legend></header><timeline-slider><div class="row"><div style="width:{{column_width}}px" ng-repeat="co2_sources in data.co2_sources" class="timeline-item"><chart-co2-sources column-width="column_width" data="co2_sources"></chart-co2-sources></div></div></timeline-slider></section><section ui-if="hasOtherActions" class="report-section report-section-other-eco-actions"><report-header-basic>{{\'artifact.report_section_titles.other_eco_actions\' | i18n}}</report-header-basic><timeline-slider><div style="white-space:normal;" class="row"><div style="width:{{column_width}}px" ng-repeat="report in reports" class="timeline-item"><section ng-repeat="actionCategory in report.other_actions" class="action-type-{{actionCategory.name | slugify}}"><div class="row aligns-middle"><i class="icon-{{actionCategory.name.icon_code | slugify}}"></i>');
  var __val__ = ' '
  buf.push(escape(null == __val__ ? "" : __val__));
  buf.push('<h5 style="text-transform:capitalize;"> {{ actionCategory.name.name }}</h5><ul><li ng-repeat="action in actionCategory.description_list"><span>{{action}}</span></li></ul></div></section></div></div></timeline-slider><br/><br/><br/></section><section ui-if="latestReport.annual_report_url" class="report-section text-align-center"><button class="btn btn-inverse v-push-4"><a href="{{latestReport.annual_report_url}}"><h3><i class="icon-download"></i> {{ \'artifact.download_report\' | i18n:latestReport.year }}</h3></a></button></section></timeline-conductor></section><br/><br/><br/><br/><br/>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/can-do-feedback": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<form class="involvement-form"><div class="row aligns-bottom"><textarea rows="8" placeholder="{{ \'feedback_message_prompt\' | i18n }}" class="col-4"></textarea><button class="btn btn-inverse col-4 h-push-1">{{ \'shoot\' | i18n }}</button></div></form>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/can-do-recruit-company": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<form class="involvement-form"><div class="row aligns-bottom"><textarea rows="8" placeholder="Your message:" class="col-4"></textarea><button class="btn btn-inverse col-4 h-push-1">Recruit company</button></div></form>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/can-do-sponsor-co2r": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<form class="involvement-form"><div class="row aligns-bottom"><textarea rows="8" placeholder="Your message:" class="col-4"></textarea><button class="btn btn-inverse col-4 h-push-1">Sponsor us</button></div></form>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/can-do-spread-word": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<form class="involvement-form"><div class="row aligns-bottom"><textarea rows="8" placeholder="Your message:" class="col-4"></textarea><button class="btn btn-inverse col-4 h-push-1">Spread the word</button></div></form>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/directory": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<div ng-show="preferences.get(\'show_introduction\')" class="row align-center v-push-2 group"><div class="vintage-box-models pin-right"><button ng-click="preferences.set(\'show_introduction\', false)" class="btn icon-remove"></button></div><div style="height:200px;" class="a-image col-6 v-push-3"><img ng-src="{{app_data.urls.introduction_figure}}" style="height:100%;"/></div><div class="introduction-copy col-6"><h1 ng-bind-html="\'introduction_title\' | i18n"></h1><div co2r-bind="\'introduction_text\' | i18n" class="introduction-text"></div><a href="/about" class="btn">{{ \'learn_more\' | i18n }}</a></div></div><form class="form-search vintage-box-models align-center"><div class="input-prepend"><span class="add-on"><span class="icon-search"></span></span><input type="text" ng-model="artifact_name" placeholder="{{\'directory.filter_input_prompt\' | i18n}}" ng-change="isotopeFilterByName(artifact_name)" class="search-query span5"/></div></form><div isotope="isotope" class="artifact-cards gutters-05 row hidden"><a isotope-item="isotope-item" href="{{artifact.slug}}" ng-repeat="artifact in artifacts" data-name="{{artifact.name.toLowerCase()}}" class="artifact-card row dark-theme"><div class="artifact-card-image"><img ng-src="{{artifact.thumbnail_url}}"/></div><div class="artifact-card-info"><h4>{{artifact.unit_quantity}}\n{{artifact.unit_verbose}}<br/><co2-contrasted amount="artifact.footprints[0].co2_per_unit"></co2-contrasted></h4><div class="organization-name">{{artifact.name}}</div></div></a></div>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/faq": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<div class="row row-couple-heights"><aside class="faq-table-of-contents"><ul ui-scrollfix="62" class="nav nav-pills nav-stacked align-right scrollfix-fixed"><li ng-repeat="faq in faqs"><a ng-href="#{{faq.question | slugify}}" ng-bind="faq.question" smooth-scroll="smooth-scroll"></a></li></ul></aside><div><div class="faqs span-8 v-gutters-3"><article id="{{faq.question | slugify}}" ng-repeat="faq in faqs" spyscrollable="spyscrollable"><header class="question"><h1>{{faq.question}}</h1></header><div ng-bind-html="faq.answer" class="answer"></div></article></div></div></div>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/form-feedback": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<textarea placeholder="{{ \'feedback_message_prompt\' | i18n}}" rows="5"></textarea><button class="btn span">{{\'shoot\' | i18n}}</button>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/list-co2-comparisons": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<ul class="unstyled"><li ng-repeat="co2_comparison in app_data.co2_artifact_comparisons" class="{{co2_comparison.type | slugify}}">{{co2_comparison.phrase}}\n {{(amount / co2_comparison.co2_amount).floor(2)}} {{co2_comparison.co2_amount_unit}}</li></ul>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/other-things": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<section ng-repeat="can_do in app_data.other_things_you_can_do" class="can-do row row-couple-heights"><div class="involvement-type"><div class="span-4 align-right"><h2>{{ can_do.label | i18n }}</h2><div ng-bind-html="can_do.description | i18n" class="description"></div></div><br/><br/></div><ng-include src="partialPath(can_do.templateName)"></ng-include></section>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/register": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<header><div class="row align-center v-push-3"><div class="introduction span-6"><h1 class="aligns-middle"><i class="icon-file"></i><span> {{ \'register_your_product\' | i18n }}</span></h1><p>{{ \'register_introduction\' | i18n}}</p></div><form class="vintage-box-models"><div class="row h-gutters-1"><textarea rows="6" placeholder=" {{ \'your_message\' | i18n }}"></textarea><div><div class="control-group"><div class="input-prepend"><label for="name" class="add-on"><i class="icon-user"></i></label><input id="name" type="text" placeholder="{{ \'name_or_organization\' | i18n }}"/></div></div><div class="control-group"><div class="input-prepend"><label for="email" class="add-on"><i class="icon-envelope"></i></label><input id="email" type="email" placeholder="{{\'email\' | i18n}}"/></div></div><div class="control-group"><div class="input-prepend"><label for="phone" class="add-on"><i class="icon-phone"></i></label><input id="phone" type="text" placeholder="{{\'phone\' | i18n}}"/></div></div><button style="box-sizing:border-box;" class="btn span">{{ \'inquire\' | i18n }}</button></div></div></form></div></header><aside style="width:40%;" class="row register-table-of-contents"><div style="margin-right:40px;margin-top:40px;margin-bottom:60px;" class="align-right"><section><h4>Benefits</h4><ul><li>Project differentiation</li><li>Competitive advantage</li><li>Engaging customers</li></ul></section><section><h4>Your toolkit</h4><ul><li>Microsite</li><li>Stickers</li><li>Signage</li><li>Use of emblem</li><li>Language</li><li>Supporting images</li></ul></section><section><h4>What you need to do</h4><ul><li>Qualify</li><li>Offset</li><li>Setup your toolkit</li></ul></section></div><div class="faqs span-8 v-gutters-3"></div><br/><br/><br/><br/><br/></aside>');
  }
  return buf.join("");
  };
}});

window.require.define({"partials/test": function(exports, require, module) {
  module.exports = function anonymous(locals, attrs, escape, rethrow, merge) {
  attrs = attrs || jade.attrs; escape = escape || jade.escape; rethrow = rethrow || jade.rethrow; merge = merge || jade.merge;
  var buf = [];
  with (locals || {}) {
  var interp;
  buf.push('<div id="map_canvas" style="width:900px;height:500px;" map="map"></div><style>.t-box {width:50px;height:50px;}\n</style><div class="row"><div class="row span-4"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div><div class="row align-right span-8"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div></div><br/><div class="row"><div style="width:50%;" class="row"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div><div class="row span-2 align-right"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div></div><br/><div class="row"><div class="row span-4"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div><div class="row span-8"><div ng-repeat="i in [1,2,3]" class="t-box">{{i}}</div></div></div><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>');
  }
  return buf.join("");
  };
}});

