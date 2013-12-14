class Demo.Routers.Products extends Backbone.Router
  routes:
    '': 'index'

  initialize: ->
    @collection = new Demo.Collections.Products()
    @collection.fetch
      reset: true

  index: ->
    view = new Demo.Views.ProductsIndex(collection: @collection)
    $('#container').html(view.render().el)