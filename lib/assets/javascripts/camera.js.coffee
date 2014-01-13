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