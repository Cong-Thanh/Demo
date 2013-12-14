class Demo.Views.Product extends Backbone.View

  template: JST['products/product']

  tagName: 'tr'

  render: ->
    $(@el).html(@template(product: @model))
    this