class @Skybox
  constructor: (@effect, @textures) ->
    Vertices = []
    TextureCoords = undefined
    VertexIndices = undefined
    
    #-------------------------------------- Front ---------------------------------------///
    Vertices[0] = [-20000, 20000, -20000, 20000, 20000, -20000, 20000, -20000, -20000, -20000, -20000, -20000]
    #-------------------------------------- BACK ---------------------------------------///
    Vertices[1] = [20000, 20000, 20000, -20000, 20000, 20000, -20000, -20000, 20000, 20000, -20000, 20000]
    #-------------------------------------- TOP ---------------------------------------///
    Vertices[2] = [-20000, 20000, 20000, 20000, 20000, 20000, 20000, 20000, -20000, -20000, 20000, -20000]
    #-------------------------------------- RIGHT ---------------------------------------///
    Vertices[3] = [20000, 20000, -20000, 20000, 20000, 20000, 20000, -20000, 20000, 20000, -20000, -20000]
    #-------------------------------------- LEFT ---------------------------------------///
    Vertices[4] = [-20000, 20000, 20000, -20000, 20000, -20000, -20000, -20000, -20000, -20000, -20000, 20000]
    #-------------------------------------- BOTTOM ---------------------------------------///
    Vertices[5] = [-30000, -2, -30000, -30000, -2, 20000, -4608 + 30, -2, 20000, -4608 + 30, -2, -30000]
    Vertices[6] = [4608 - 30, -2, -30000, 4608 - 30, -2, 20000, 20000, -2, 20000, 20000, -2, -30000]
    Vertices[7] = [-4608, -2, -30000, -4608, -2, -4608 + 30, 4608, -2, -4608 + 30, 4608, -2, -30000]
    Vertices[8] = [-4608, -2, 4608 - 30, -4608, -2, 20000, 4608, -2, 20000, 4608, -2, 4608 - 30]
  
    #-------------------------------------- TEXTURE -- INDEX -----------------------------///
    TextureCoords = [0.0, 1.0, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0]
    VertexIndices = [0, 1, 2, 0, 2, 3] # Front face
    @vertexTextureCoordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(TextureCoords), gl.STATIC_DRAW
    @vertexTextureCoordBuffer.itemSize = 2
    @vertexTextureCoordBuffer.numItems = TextureCoords.length / 2
    @vertexIndexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(VertexIndices), gl.STATIC_DRAW
    @vertexIndexBuffer.itemSize = 1
    @vertexIndexBuffer.numItems = VertexIndices.length
    @vertexPositionBuffer = new Array(7)
    i = 0
    while i < 9
      @vertexPositionBuffer[i] = gl.createBuffer()
      gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer[i]
      gl.bufferData gl.ARRAY_BUFFER, new Float32Array(Vertices[i]), gl.STATIC_DRAW
      @vertexPositionBuffer[i].itemSize = 3
      @vertexPositionBuffer[i].numItems = Vertices[i].length / 3
      i++

  draw: (camera) ->
    gl.disable gl.BLEND
    gl.useProgram @effect.shaderProgram
    @setEffectParams camera.pMatrix, camera.vMatrix, @effect.shaderProgram
    i = 0

    while i < 9
      gl.activeTexture gl.TEXTURE0
      if i > 5
        gl.bindTexture gl.TEXTURE_2D, @textures[5]
      else
        gl.bindTexture gl.TEXTURE_2D, @textures[i]
      gl.uniform1i @effect.shaderProgram.samplerUniform, 0
      gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer[i]
      gl.vertexAttribPointer @effect.shaderProgram.vertexPositionAttribute, @vertexPositionBuffer[i].itemSize, gl.FLOAT, false, 0, 0
      gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer
      gl.drawElements gl.TRIANGLES, @vertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0
      gl.bindTexture gl.TEXTURE_2D, null
      i++

  setEffectParams: (pMatrix, vMatrix, shaderProgram) ->
    unless shaderProgram.isReady?
      shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition")
      gl.enableVertexAttribArray shaderProgram.vertexPositionAttribute
      shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord")
      gl.enableVertexAttribArray shaderProgram.textureCoordAttribute
      shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
      shaderProgram.vMatrixUniform = gl.getUniformLocation(shaderProgram, "uVMatrix")
      shaderProgram.samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler")
      shaderProgram.isReady = true
    gl.uniformMatrix4fv shaderProgram.pMatrixUniform, false, pMatrix
    gl.uniformMatrix4fv shaderProgram.vMatrixUniform, false, vMatrix
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.vertexAttribPointer shaderProgram.textureCoordAttribute, @vertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0