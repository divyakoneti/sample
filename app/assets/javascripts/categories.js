var categoryCenter = angular.module('CategoryCenter', ['ngResource']);

categoryCenter.factory("Category", function($resource) {
  return $resource("categories/:id", { id: '@id' }, {
    index:   { method: 'GET', isArray: true, responseType: 'json' },
    update:  { method: 'PUT', responseType: 'json' }
  });
})

categoryCenter.controller("categoriesController", function($scope, Category) {
  $scope.category = Category.index()

  $scope.addCategory = function() {
    category = Category.save($scope.newCategory)

    $scope.categories.push(category)
    $scope.newCategory = {}
  }

  $scope.deleteCategory = function(index) {
    
    category = $scope.category[index]
    Category.delete(category)
    $scope.categories.splice(index, 1);
  }
})