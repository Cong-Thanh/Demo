# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = angular.module("PhoneBook", ["ngResource"])

app.config ["$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.factory "Contact", ($resource) ->
  $resource("/api/v1/contacts/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@PhoneBookCtrl = ($scope, Contact) ->
  $scope.contacts = Contact.query()

  $scope.addContact = ->
    contact = Contact.save($scope.newContact)
    $scope.contacts.push contact
    $scope.newContact = {}

  $scope.edit = (contact) ->
    contact.state = 'editing'
    contact.edit = 
      name: contact.name
      phone: contact.phone
      email: contact.email

  $scope.update = (contact) ->
    contact.name = contact.edit.name
    contact.phone = contact.edit.phone
    contact.email = contact.edit.email
    contact.state = 'show'
    contact.$update()

  $scope.destroy = (contact) ->
    contact.$delete()
    $scope.contacts.splice($scope.contacts.indexOf(contact), 1)