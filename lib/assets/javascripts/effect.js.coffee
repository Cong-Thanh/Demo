class @Effect
  constructor: (code)->
    [vsCode, fsCode] = code.split("--")
    vertexShader = Effect.getShader(vsCode, gl.VERTEX_SHADER)
    fragmentShader = Effect.getShader(fsCode, gl.FRAGMENT_SHADER)

    @shaderProgram = gl.createProgram()
    gl.attachShader @shaderProgram, vertexShader
    gl.attachShader @shaderProgram, fragmentShader
    gl.linkProgram @shaderProgram
    alert "Could not initialise shaders"  unless gl.getProgramParameter(@shaderProgram, gl.LINK_STATUS)

  @getShader = (code, shaderType) ->
    shader = gl.createShader(shaderType)
    gl.shaderSource shader, code
    gl.compileShader shader
    unless gl.getShaderParameter(shader, gl.COMPILE_STATUS)
      alert gl.getShaderInfoLog(shader)
      return null
    shader