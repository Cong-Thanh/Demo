# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("Task", ["ngResource"])

app.factory "TaskItem", ($resource) ->
  $resource("/api/v1/task_items/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@TaskItemCtrl = ($scope, TaskItem) ->
  $scope.task_items = TaskItem.query()

  $scope.addTaskItem = ->
    task_item = TaskItem.save($scope.newTaskItem)
    $scope.task_items.push task_item
    $scope.newTaskItem = {}
