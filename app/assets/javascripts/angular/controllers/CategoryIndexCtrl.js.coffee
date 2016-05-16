@sample_rspec.controller 'CategoryIndexCtrl', ['$scope', '$location', '$http', ($scope, $location, $http) ->
  $scope.categories = []
  $http.get('./categories.json').success((data) ->
    $scope.categories = data
  )
]