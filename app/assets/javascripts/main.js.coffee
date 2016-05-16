# This line is related to our Angular app, not to our
# HomeCtrl specifically. This is basically how we tell
# Angular about the existence of our application.
@sample_rspec = angular.module('sample_rspec', [])

# This routing directive tells Angular about the default
# route for our application. The term "otherwise" here
# might seem somewhat awkward, but it will make more
# sense as we add more routes to our application.
@sample_rspec.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/restaurants', {
      templateUrl: '../templates/categories/index.html',
      controller: 'CategoryIndexCtrl'
    }).
    otherwise({
      templateUrl: '../templates/home.html',
      controller: 'HomeCtrl'
    })
])