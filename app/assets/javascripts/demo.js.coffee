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
