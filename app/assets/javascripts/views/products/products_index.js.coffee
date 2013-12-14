class Demo.Views.ProductsIndex extends Backbone.View

  template: JST['products/index']

  id: "content"

  events:
    'submit #new_product': 'createProduct'

  initialize: ->
    @collection.on('reset', @render, this)
    @collection.on('add', @appendEntry, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendEntry)
    this

  appendEntry: (product) ->
    view = new Demo.Views.Product(model: product)
    $('#products tr:last').after(view.render().el)

  createProduct: (event) ->
    event.preventDefault()
    
    attributes = 
      name: $('#new_product_name').val()
      price: $('#new_product_price').val()
      quantity: $('#new_product_quantity').val()
    
    @collection.create attributes,
      wait: true
      success: -> $("#new_product")[0].reset()
      error: @handleError

  handleError: (product, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText)
      @$(".field").removeClass("error")
      @$(".field .help_inline").text("")
      for attribute, messages of errors["errors"]
        field = @$("." + attribute)
        field.addClass("error")
        field.find(".help_inline").text(attribute + " " + messages[0])