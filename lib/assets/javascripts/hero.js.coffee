class @Hero
  constructor: (@animationModels, @ws, @billboardModel) ->
    @translate = new Vector3(0, 0, 0)
    @rotate = new Vector3(0, 0, 0)
    @index = 0

  draw: (camera) ->
    for model in @animationModels[@index]
      model.draw(camera, mat4.rotate(mat4.scale(mat4.translate(mat4.identity(mat4.create()), [@translate.x, @translate.y, @translate.z]), [1.5,1.5,1.5]), Util.degToRad(@rotate.y), [0, 1, 0]))

    gl.blendFunc gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA
    gl.enable gl.BLEND
    tempMatrix = mat4.identity(mat4.create())
    mat4.translate tempMatrix, [
      @translate.x
      @translate.y + 220
      @translate.z
    ]
    @billboardModel.draw camera, tempMatrix, 128, 128, mat4.identity(mat4.create()) if @billboardModel
    

  update: (elapsed, camera, terrain) =>
    a = @index
    @index = @updateMovement(camera, terrain) if @ws
    b = @index
    for model in @animationModels[@index]
      model.update elapsed

    if @ws and ((a != b) || (@index == 1))
      @ws.send JSON.stringify
        e: "update_my_position"
        d:
          id: @ws.id
          position:
            translate: @translate
            rotate: @rotate
            index: @index

  updateMovement: (camera, terrain) ->
    @translate.y = terrain.GetHeight(@translate.x, @translate.z)
  
    flag = 0
    vec2
    
    #a & !d & !s & !w
    if KeyState.currentlyPressedKeys[65] and not KeyState.currentlyPressedKeys[68] and not KeyState.currentlyPressedKeys[83] and not KeyState.currentlyPressedKeys[87]
      vec2 = [@translate.z - camera.position.z, camera.position.x - @translate.x]
      flag = 1
    
    #a  & !d  & !s & w
    if KeyState.currentlyPressedKeys[65] and not KeyState.currentlyPressedKeys[68] and not KeyState.currentlyPressedKeys[83] and KeyState.currentlyPressedKeys[87]
      vec11 = [@translate.x - camera.position.x, @translate.z - camera.position.z]
      vec2 = [@translate.z - camera.position.z + vec11[0], camera.position.x - @translate.x + vec11[1]]
      flag = 1
    
    #a & !d & s & !w 
    if KeyState.currentlyPressedKeys[65] and not KeyState.currentlyPressedKeys[68] and KeyState.currentlyPressedKeys[83] and not KeyState.currentlyPressedKeys[87]
      vec11 = [camera.position.x - @translate.x, camera.position.z - @translate.z]
      vec2 = [@translate.z - camera.position.z + vec11[0], camera.position.x - @translate.x + vec11[1]]
      flag = 1
    
    # !a & d & !s & !w   
    if not KeyState.currentlyPressedKeys[65] and KeyState.currentlyPressedKeys[68] and not KeyState.currentlyPressedKeys[83] and not KeyState.currentlyPressedKeys[87]
      vec2 = [camera.position.z - @translate.z, @translate.x - camera.position.x]
      flag = 1
    
    # !a & d & s & !w
    if not KeyState.currentlyPressedKeys[65] and KeyState.currentlyPressedKeys[68] and KeyState.currentlyPressedKeys[83] and not KeyState.currentlyPressedKeys[87]
      vec11 = [camera.position.x - @translate.x, camera.position.z - @translate.z]
      vec2 = [camera.position.z - @translate.z + vec11[0], @translate.x - camera.position.x + vec11[1]]
      flag = 1
    
    # !a & d & !s & w
    if not KeyState.currentlyPressedKeys[65] and KeyState.currentlyPressedKeys[68] and not KeyState.currentlyPressedKeys[83] and KeyState.currentlyPressedKeys[87]
      vec11 = [@translate.x - camera.position.x, @translate.z - camera.position.z]
      vec2 = [camera.position.z - @translate.z + vec11[0], @translate.x - camera.position.x + vec11[1]]
      flag = 1
    
    # !a & !d & !s & w
    if not KeyState.currentlyPressedKeys[65] and not KeyState.currentlyPressedKeys[68] and not KeyState.currentlyPressedKeys[83] and KeyState.currentlyPressedKeys[87]
      vec2 = [@translate.x - camera.position.x, @translate.z - camera.position.z]
      flag = 1
    
    # !a & !d & s & !w
    if not KeyState.currentlyPressedKeys[65] and not KeyState.currentlyPressedKeys[68] and KeyState.currentlyPressedKeys[83] and not KeyState.currentlyPressedKeys[87]
      vec2 = [camera.position.x - @translate.x, camera.position.z - @translate.z]
      flag = 1
    
    if flag is 1
      vec = [0, 0, 1]
      tmpMatrix = mat4.create()
      mat4.identity tmpMatrix
      mat4.rotateY tmpMatrix, Util.degToRad(@rotate.y)
      mat4.multiplyVec3 tmpMatrix, vec
      vec1 = [vec[0], vec[2]]
      cos = (vec1[0] * vec2[0] + vec1[1] * vec2[1]) / Math.sqrt(Math.pow(vec1[0], 2) + Math.pow(vec1[1], 2)) / Math.sqrt(Math.pow(vec2[0], 2) + Math.pow(vec2[1], 2))
      angle = Math.round(Util.radToDeg(Math.acos(cos)))
      if KeyState.currentlyPressedKeys[68]
        @rotate.y += angle * -1
      else
        @rotate.y += angle
      @translate.z += Math.round(Math.cos(Util.degToRad(@rotate.y)) * Global.moveSpeed)
      @translate.x += Math.round(Math.sin(Util.degToRad(@rotate.y)) * Global.moveSpeed)
    
    flag