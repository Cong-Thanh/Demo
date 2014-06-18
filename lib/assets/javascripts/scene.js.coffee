class @Scene
  constructor: (s) ->
    @stack_bottomleft = {"dir1": "up", "dir2": "right", "push": "top"}
    PNotify.prototype.options.styling = "bootstrap2"    
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
        "basic.txt",
        "billboard.txt",
        "terrain.txt",
        "skybox.txt",
        "TownHall.jpg", 
        "Water.jpg",
        "Grass.png",
        "Snow.jpg",
        "back.jpg",
        "front.jpg",
        "left.jpg",
        "right.jpg",
        "top.jpg",
        "GrassBottom.png",
        "HumanLumberMill.jpg",
        "WorkShop.jpg",
        "HumanBarrack.jpg",
        "HumanTower.jpg",
        "Farm.jpg",
        "Tree.jpg",
        "HumanTower.jpg",
        "WomanBlue.jpg",
        "ManBrown.jpg",
        "Footman.jpg",
        "lichkingbody.jpg",
        "lichkinghead.jpg",
        "lichkingsword.jpg",
        "Highland.png",
        "name.png"
    ]
    
    async.whilst (=>
      $.isEmptyObject(@content.load)
    ), ((callback) =>
      setTimeout callback, 1000
    ), (err) =>
      @staticModels = [
        model: new Model townhall, @content.load["TownHall.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-630, 0, -630]), [300,300,300]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model lumbermill, @content.load["HumanLumberMill.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-2430, 0, -270]), [2,2,2]), Util.degToRad(45), [0, 1, 0])
      ,
        model: new Model workshop, @content.load["WorkShop.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-1710, 9, -1710]), [200,200,200]), Util.degToRad(-45), [0, 1, 0])
      ,
        model: new Model humanbarrack, @content.load["HumanBarrack.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-1710, 0, 810]), [300,300,300]), Util.degToRad(165), [0, 1, 0])
      ,
        model: new Model humantower, @content.load["HumanTower.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [1170, 0, -1710]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model humantower, @content.load["HumanTower.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [1350, 0, -630]), [200,200,200]), Util.degToRad(160), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-270, 0, 990]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-630, 0, 990]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [90, 0, 990]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [450, 0, 990]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-270, 0, -2070]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-630, 0, -2070]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [90, 0, -2070]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model farm, @content.load["Farm.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [450, 0, -2070]), [2,2,2]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [450, 0, -2430]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [90, 0, -2430]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-270, 0, -2430]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-630, 0, -2430]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [450, 0, 1350]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [90, 0, 1350]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-270, 0, 1350]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ,
        model: new Model tree, @content.load["Tree.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-630, 0, 1350]), [200,200,200]), Util.degToRad(135), [0, 1, 0])
      ]

      @animationModels = [
        model: new AnimationModel standwoman, @content.load["WomanBlue.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [450, 0, -990]), [2,2,2]), Util.degToRad(60), [0, 1, 0])
      ,
        model: new AnimationModel man, @content.load["ManBrown.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-1350, 3, -1782]), [2,2,2]), Util.degToRad(60), [0, 1, 0])
      ,
        model: new AnimationModel man, @content.load["ManBrown.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-2250, 0, -630]), [2,2,2]), Util.degToRad(90), [0, 1, 0])
      ,
        model: new AnimationModel footman, @content.load["Footman.jpg"], new Effect @content.load["basic.txt"]
        matrix: mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [-1530, 0, 342]), [2,2,2]), Util.degToRad(140), [0, 1, 0])
      ]

      mainheromodels = [
        [
          new AnimationModel herobodystand, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
        ,
          new AnimationModel heroheadstand, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
        ,
          new AnimationModel heroweaponstand, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
        ]
      , 
        [
          new AnimationModel herobodywalk, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
        ,
          new AnimationModel heroheadwalk, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
        ,
          new AnimationModel heroweaponwalk, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
        ]
      ]
      
      @other_heroes = {}

      @socket = io.connect("http://ec2-54-183-105-129.us-west-1.compute.amazonaws.com:8080")
      
      @socket.on "connect", =>
        @socket.emit "add_me", window.name

      @socket.on "current_state", (positions) =>
        for id of positions
          billboardmodel = new BillboardModel @createTextImage(positions[id].name), new Effect @content.load["billboard.txt"]
          heromodels = [
            [
              new AnimationModel herobodystand, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
            ,
              new AnimationModel heroheadstand, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
            ,
              new AnimationModel heroweaponstand, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
            ]
          , 
            [
              new AnimationModel herobodywalk, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
            ,
              new AnimationModel heroheadwalk, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
            ,
              new AnimationModel heroweaponwalk, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
            ]
          ]
          hero = new Hero heromodels, undefined, billboardmodel
          hero.translate = positions[id].translate || new Vector3(0, 0, 0)
          hero.rotate = positions[id].rotate || new Vector3(0, 0, 0)
          hero.index = positions[id].index || 0
          @other_heroes[id] = hero   

      @socket.on "new_client", (id, name) =>
        billboardmodel = new BillboardModel @createTextImage(name), new Effect @content.load["billboard.txt"]
        heromodels = [
          [
            new AnimationModel herobodystand, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
          ,
            new AnimationModel heroheadstand, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
          ,
            new AnimationModel heroweaponstand, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
          ]
        , 
          [
            new AnimationModel herobodywalk, @content.load["lichkingbody.jpg"], new Effect @content.load["basic.txt"]
          ,
            new AnimationModel heroheadwalk, @content.load["lichkinghead.jpg"], new Effect @content.load["basic.txt"]
          ,
            new AnimationModel heroweaponwalk, @content.load["lichkingsword.jpg"], new Effect @content.load["basic.txt"]
          ]
        ]
        @other_heroes[id] = new Hero heromodels, undefined, billboardmodel

      @socket.on "update_client_position", (id, position) =>
        @other_heroes[id].translate = position.translate
        @other_heroes[id].rotate = position.rotate   
        @other_heroes[id].index = position.index        

      @socket.on "client_left", (id) =>
        delete @other_heroes[id]

      @socket.on "message", (msg) =>
        new PNotify
          text: msg
          type: "info"
          addclass: "stack-bottomleft"
          stack: @stack_bottomleft        

      @hero = new Hero mainheromodels, @socket

      @camera = new Camera()
      @camera.setProjection(45,gl.viewportWidth/gl.viewportHeight,0.1,50000)
      @camera.setLookAt(new Vector3(0, 250, -700), new Vector3(0,0,0), new Vector3(0,1,0))
      highLevel = [
        {min: 0, max: 0, texture: @content.load["Water.jpg"]},
        {min: -1, max: 50, texture: @content.load["Grass.png"]},
        {min: 100, max: 150, texture: @content.load["Highland.png"]} ,
        {min: 200, max: 255, texture: @content.load["Snow.jpg"]}
      ]
      @terrain = new Terrain(256, 256, 36, 3, new Effect(@content.load["terrain.txt"]), highLevel, heightMap)
      window.terrain = @terrain
      textures = [
        @content.load["back.jpg"],
        @content.load["front.jpg"],
        @content.load["left.jpg"],
        @content.load["right.jpg"],
        @content.load["top.jpg"],
        @content.load["GrassBottom.png"]
      ]
      @skybox = new Skybox(new Effect(@content.load["skybox.txt"]), textures)
    
    KeyState.load()

  loop: =>
    requestAnimFrame @loop
    @update()
    @draw()

  draw: ->
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
    if @staticModels
      for obj in @staticModels
        obj.model.draw(@camera, obj.matrix)
    if @animationModels
      for obj in @animationModels
        obj.model.draw(@camera, obj.matrix)
    @terrain.draw(@camera) if @terrain
    @skybox.draw(@camera) if @skybox
    @hero.draw(@camera) if @hero
    for id of @other_heroes
      @other_heroes[id].draw(@camera)

  show: ->
    @loop()

  update: ->
    timeNow = new Date().getTime()
    elapsed = timeNow - @lastTime
    if @animationModels
      for obj in @animationModels
        obj.model.update elapsed
    @hero.update(elapsed, @camera, @terrain) if @hero and @camera and @terrain
    
    for id of @other_heroes
      @other_heroes[id].update(elapsed, @camera, @terrain)
    
    @camera.update(elapsed, @hero.translate) if @camera
    @lastTime = timeNow

  createTextImage: (text) =>
    image = document.createElement("canvas")
    ctx = image.getContext("2d")
    tmpImage = document.createElement("canvas")
    tmpctx = tmpImage.getContext("2d")
    tmpctx.font = "bold 22px Arial"
    tmpctx.textAlign = "left"
    tmpctx.textBaseline = "top"
    image.setAttribute "width", 512
    image.setAttribute "height", 512
    ctx.fillStyle = "white"
    ctx.lineWidth = 0
    ctx.strokeStyle = "white"
    ctx.save()
    ctx.font = "bold 49px Arial"
    ctx.textAlign = "center"
    ctx.textBaseline = "middle"
    ctx.drawImage @content.load["name.png"].image, 0, 0, 512, 512
    list = []
    list.push text  if text.length < 20
    if text.length >= 20 and text.length < 40
      j = 20

      while j >= 0
        if text[j] is " "
          list.push text.substring(0, j)
          list.push text.substring(j, text.length)
          break
        j--
    if text.length > 40
      tmp = undefined
      j = 20

      while j >= 0
        if text[j] is " "
          list.push text.substring(0, j)
          tmp = j
          break
        j--
      j = tmp + 20

      while j > tmp
        if text[j] is " "
          list.push text.substring(tmp, j)
          list.push text.substring(j, text.length)
          break
        j--
    j = 0

    while j < list.length
      ctx.fillText list[j], ctx.canvas.width / 2, ctx.canvas.height / 6 + 60 * j - 30
      j++
    ctx.restore()
    newtexture = gl.createTexture()
    gl.enable gl.TEXTURE_2D
    gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
    gl.bindTexture gl.TEXTURE_2D, newtexture
    gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, image
    gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR
    gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST
    gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.REPEAT
    gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.REPEAT
    gl.generateMipmap gl.TEXTURE_2D
    gl.bindTexture gl.TEXTURE_2D, null
    newtexture