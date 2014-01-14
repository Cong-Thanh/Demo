class @Scene
  constructor: (s) ->
    $el = $("#{s}")
    window.gl = $el[0].getContext("experimental-webgl")
    width = $el.width()
    height = $el.height()
    $el.attr("width", width)
    $el.attr("height", height)
    gl.viewportWidth = width
    gl.viewportHeight = height
    gl.viewport(0, 0, width, height);
    gl.clearColor(0.1, 0.149, 0.237, 1.0)
    gl.enable(gl.DEPTH_TEST)
    
    @content = new Content [
        "assets/basic.txt",
        "assets/terrain.txt",
        "assets/TownHall.jpg", 
        "assets/Water.jpg",
        "assets/Grass.png",
        "assets/Snow.jpg",
        "assets/Highland.png"
    ]

    async.whilst (=>
      $.isEmptyObject(@content.load)
    ), ((callback) =>
      setTimeout callback, 1000
    ), (err) =>
      @model = new Model modelData, @content.load["assets/TownHall.jpg"], new Effect @content.load["assets/basic.txt"]
      @camera = new Camera()
      @camera.setProjection(45,gl.viewportWidth/gl.viewportHeight,0.1,50000)
      @camera.setLookAt(new Vector3(0, 250, -700), new Vector3(0,0,0), new Vector3(0,1,0))
      highLevel = [
        {min: 0, max: 0, texture: @content.load["assets/Water.jpg"]},
        {min: -1, max: 50, texture: @content.load["assets/Grass.png"]},
        {min: 100, max: 150, texture: @content.load["assets/Highland.png"]} ,
        {min: 200, max: 255, texture: @content.load["assets/Snow.jpg"]}
      ]
      @terrain = new Terrain(256, 256, 36, 3, new Effect(@content.load["assets/terrain.txt"]), highLevel, heightMap)

    KeyState.load()

  loop: =>
    requestAnimFrame @loop
    @update()
    @draw()

  draw: ->
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
    @model.draw(@camera, mat4.scale(mat4.identity(mat4.create()), [300,300,300])) if @model
    @terrain.draw(@camera) if @terrain

  show: ->
    @loop()

  update: ->
    timeNow = new Date().getTime()
    elapsed = timeNow - @lastTime
    @camera.update elapsed if @camera
    @lastTime = timeNow