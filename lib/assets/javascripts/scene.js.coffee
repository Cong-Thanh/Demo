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
        "basic.txt",
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
        "Highland.png"
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
      @hero = new Hero heromodels

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
    @hero.draw(@camera) if @hero
    @terrain.draw(@camera) if @terrain
    @skybox.draw(@camera) if @skybox

  show: ->
    @loop()

  update: ->
    timeNow = new Date().getTime()
    elapsed = timeNow - @lastTime
    if @animationModels
      for obj in @animationModels
        obj.model.update elapsed
    @hero.update(elapsed, @camera, @terrain) if @hero and @camera and @terrain
    @camera.update(elapsed, @hero.translate) if @camera
    @lastTime = timeNow