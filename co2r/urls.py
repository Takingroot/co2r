from django.conf.urls import patterns, include, url
from django.views.generic.base import TemplateView
# Uncomment the next two lines to enable the admin:
from django.contrib import admin
from django.conf import settings

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^$', TemplateView.as_view(template_name='index.html'), name='index'),
)

if settings.DEBUG:
    urlpatterns += patterns('django.contrib.staticfiles.views',
        url(r'^static/(?P<path>.*)$', 'serve'),
    )

#
# Important! Route everything else to index.html so that our client-app can handle the url
#
# Users could enter our HTML5 app at any ***client-defined*** route, for example:
#   * co2r.com/directory/santra-pool
#   * co2r.com/our-mission
#   * co2r.com/how-you-can-help
# all of the above urls would fail unless django let our client-app handle the url which means sending users to index.html
#
urlpatterns += patterns('',
    url('.', TemplateView.as_view(template_name='index.html'), name='index'),
)
