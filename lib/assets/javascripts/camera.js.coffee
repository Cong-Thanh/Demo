class @Camera
  constructor: ->
    @vMatrix = mat4.create()
    @pMatrix = mat4.create()
    mat4.identity @vMatrix
    mat4.identity @pMatrix

  setLookAt: (pos, target, up) ->
    @position = pos
    @target = target
    @upvec = up
    mat4.lookAt [@position.x, @position.y, @position.z], [@target.x, @target.y, @target.z], [@upvec.x, @upvec.y, @upvec.z], @vMatrix

  setProjection: (fovy, aspect, near, far) ->
    @fovy = fovy
    @aspectRatio = aspect
    @nearPlane = near
    @farPlane = far
    mat4.perspective @fovy, @aspectRatio, @nearPlane, @farPlane, @pMatrix

  update: (elapsed) ->
    if KeyState.currentlyPressedKeys[65] # A
      @leftRight = -1
    else if KeyState.currentlyPressedKeys[68] # D
      @leftRight = 1
    else
      @leftRight = 0

    if KeyState.currentlyPressedKeys[83] # W
      @upDown = -1
    else if KeyState.currentlyPressedKeys[87] # S
      @upDown = 1
    else
      @upDown = 0
    
    if KeyState.currentlyPressedKeys[74] # J
      @rotxzrate = 0.1
    else if KeyState.currentlyPressedKeys[76] # L
      @rotxzrate = -0.1
    else
      @rotxzrate = 0

    if KeyState.currentlyPressedKeys[73] # I
      @xz = 1
    else if KeyState.currentlyPressedKeys[75] # K
      @xz = -1
    else
      @xz = 0

    temp1
    temp3

    if @target.x is @position.x and @target.z isnt @position.z
      temp1 = [(@position.z - @target.z)/Math.abs(@position.z - @target.z), 0]
      temp3 = [0, (@target.z - @position.z)/Math.abs(@target.z - @position.z)]

    if @target.z is @position.z and @target.x isnt @position.x
      temp1 = [0, (@target.x - @position.x)/Math.abs(@target.x - @position.x)]
      temp3 = [(@target.x - @position.x)/Math.abs(@target.x - @position.x), 0]
    
    if @target.x isnt @position.x and @target.z isnt @position.z
      temp = Math.max(Math.abs(@position.z-@target.z), Math.abs(@target.x-@position.x))
      temp1 = [(@position.z-@target.z)/temp, (@target.x-@position.x)/temp]
      temp2 = Math.max(Math.abs(@target.x-@position.x), Math.abs(@target.z-@position.z))
      temp3 = [(@target.x-@position.x)/temp2, (@target.z-@position.z)/temp2]

    @position.x += (temp1[0]*@leftRight + temp3[0]*@upDown)*Global.moveSpeed
    @target.x += (temp1[0]*@leftRight + temp3[0]*@upDown)*Global.moveSpeed
    @position.z += (temp1[1]*@leftRight + temp3[1]*@upDown)*Global.moveSpeed
    @target.z += (temp1[1]*@leftRight + temp3[1]*@upDown)*Global.moveSpeed

    unless @xz is 0
      xxx = @position.x - @target.x
      zzz = @position.z - @target.z
      @position.x += xxx / 1000 * @xz * elapsed
      @position.z += zzz / 1000 * @xz * elapsed
      @position.y += @xz * elapsed
    
    unless @rotxzrate is 0
      @rotxz = @rotxzrate * elapsed
      @rotxz = Math.round(@rotxz * 10) / 10
      tmp = [@position.x, @position.y, @position.z]
      tmpMatrix = mat4.create()
      mat4.identity tmpMatrix
      mat4.translate tmpMatrix, [@target.x, @target.y, @target.z]
      mat4.rotate tmpMatrix, Util.degToRad(@rotxz), [0, 1, 0]
      mat4.translate tmpMatrix, [-@target.x, -@target.y, -@target.z]
      mat4.multiplyVec3 tmpMatrix, tmp
      @position.x = Math.round(tmp[0])
      @position.y = Math.round(tmp[1])
      @position.z = Math.round(tmp[2])

    mat4.lookAt [@position.x, @position.y, @position.z], [@target.x, @target.y, @target.z], [@upvec.x, @upvec.y, @upvec.z], @vMatrix