class @Scene
  constructor: (s) ->
    el = $("#{s}")[0]
    window.gl = el.getContext("experimental-webgl")
    gl.viewportWidth = $(el).width()
    gl.viewportHeight = $(el).height()                
    gl.clearColor(0.1, 0.149, 0.237, 1.0)
    gl.enable(gl.DEPTH_TEST)
    
    @content = new Content(["assets/TownHall.jpg", "assets/basic.txt"])

    async.whilst (=>
      $.isEmptyObject(@content.content)
    ), ((callback) =>
      setTimeout callback, 1000
    ), (err) =>
      @model = new Model modelData, @content.content["assets/TownHall.jpg"], new Effect @content.content["assets/basic.txt"]
      @camera = new Camera()
      @camera.setProjection(45,gl.viewportWidth/gl.viewportHeight,0.1,50000)
      @camera.setLookAt(new Vector3(0,0, 10), new Vector3(0,0,0), new Vector3(0,1,0))

    # async.until (=>
    #   debugger
    #   $.isEmptyObject(@content.content) == true
    # ), (callback) ->
    #   setTimeout callback, 1000
    # , (err) ->
    
    #while $.isEmptyObject(@content.content)
    #  a = 1

    # debugger
    # async.parallel [(callback) ->
    #   texture = gl.createTexture()
    #   texture.image = new Image()
    
    #   texture.image.onload = ->   

    #     gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
    #     gl.bindTexture gl.TEXTURE_2D, texture
    #     gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image
    #     gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR
    #     gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST
    #     gl.generateMipmap gl.TEXTURE_2D
    #     gl.bindTexture gl.TEXTURE_2D, null
    #     callback null, texture
    #   texture.image.src = "assets/TownHall.jpg"

    # , (callback) ->
    #   $.get "assets/basic.txt", (data) ->
    #     callback null, data

    # ], (err, results) =>
    # @model = new Model modelData, results[0], new Effect results[1]

    # @camera = new Camera()
    # @camera.setProjection(45,gl.viewportWidth/gl.viewportHeight,0.1,50000)
    # @camera.setLookAt(new Vector3(0,0, 10), new Vector3(0,0,0), new Vector3(0,1,0))
    
    # @terrain = new Terrain 256, 256, 36, 3, new Effect 

  loop: =>
    requestAnimationFrame @loop
    @drawScene()
  
  drawScene: ->
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
    @model.draw(@camera, mat4.identity(mat4.create())) if @model

  show: ->
    @loop()
