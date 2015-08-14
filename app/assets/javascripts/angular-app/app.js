this.app = angular.module('app', ['templates']);

// var apiRootConfig = ["$provide", function ($provide) {
//     var linkHref = $('#apiRoot').attr('href');
//     var href = !linkHref ? '' : linkHref
//     $provide.value("apiRoot", href);
//     $provide.value("railsRoot", href.replace('/api',''));
//   }];

// angular.module('modelApp.services', ['ngResource'])
//   .config(apiRootConfig);

// angular.module('modelApp.directives', []);
// angular.module('modelApp.controllers', [])
//   .config(apiRootConfig);

this.app.config([
  '$httpProvider', function($httpProvider) {
    return $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

this.app.run(function() {
  return console.log('angular app running');
});
