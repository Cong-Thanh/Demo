window.Demo =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
    new Demo.Routers.Products()
    Backbone.history.start()

$(document).ready ->
  Demo.initialize()

# app = angular.module("Product", ["ngResource"])

# @ProductCtrl = ($scope, $resource) ->
#   Product = $resource("/api/v1/products/:id", {id: "@id"},  {update: {method: "PUT"}})
  
#   $scope.products = Product.query()

#   $scope.addProduct = ->
#     product = Product.save($scope.newProduct)
#     $scope.products.push product
#     $scope.newProduct = {}

#   $scope.drawWinner = ->
#     product = $scope.products[Math.round(Math.random()*10)]
#     product.winner = true
#     product.$update()
#     $scope.lastWinner = product
