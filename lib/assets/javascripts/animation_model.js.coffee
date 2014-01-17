class @AnimationModel
  constructor: (data, @texture, @effect) ->
    @vertexTextureCoordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(data.vertexTextureCoords), gl.STATIC_DRAW
    @vertexTextureCoordBuffer.itemSize = 2
    @vertexTextureCoordBuffer.numItems = data.vertexTextureCoords.length / 2
   
    @vertexPositionBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(data.animations[0]), gl.STATIC_DRAW
    @vertexPositionBuffer.itemSize = 3
    @vertexPositionBuffer.numItems = data.animations[0].length / 3
    
    if data.indices.length is 0
      i = 0
      while i < data.animations[0].length / 3
        data.indices.push i
        i++

    @vertexIndexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(data.indices), gl.STATIC_DRAW
    @vertexIndexBuffer.itemSize = 1
    @vertexIndexBuffer.numItems = data.indices.length
    
    @animation = data.animations
    @currentIndex = 0
    @elapsed = 0

  draw: (camera, wMatrix) ->
    gl.blendFunc gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA
    gl.enable gl.BLEND
    gl.useProgram @effect.shaderProgram
    @setEffectParams camera.pMatrix, camera.vMatrix, wMatrix, @effect.shaderProgram
    gl.drawElements gl.TRIANGLES, @vertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0

  setEffectParams: (pMatrix, vMatrix, wMatrix, shaderProgram) ->
    unless shaderProgram.isReady?
      shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition")
      gl.enableVertexAttribArray shaderProgram.vertexPositionAttribute
      shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord")
      gl.enableVertexAttribArray shaderProgram.textureCoordAttribute
      shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
      shaderProgram.vMatrixUniform = gl.getUniformLocation(shaderProgram, "uVMatrix")
      shaderProgram.wMatrixUniform = gl.getUniformLocation(shaderProgram, "uWMatrix")
      shaderProgram.samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler")
      shaderProgram.isReady = true
      
    gl.uniformMatrix4fv shaderProgram.pMatrixUniform, false, pMatrix
    gl.uniformMatrix4fv shaderProgram.vMatrixUniform, false, vMatrix
    gl.uniformMatrix4fv shaderProgram.wMatrixUniform, false, wMatrix
    gl.activeTexture gl.TEXTURE0
    gl.bindTexture gl.TEXTURE_2D, @texture
    gl.uniform1i shaderProgram.samplerUniform, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.vertexAttribPointer shaderProgram.vertexPositionAttribute, @vertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.vertexAttribPointer shaderProgram.textureCoordAttribute, @vertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer

  update: (elapsed) ->
    @elapsed += elapsed
    if @elapsed >= 100
      @currentIndex++
      @currentIndex = @currentIndex % @animation.length
      gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
      gl.bufferData gl.ARRAY_BUFFER, new Float32Array(@animation[@currentIndex]), gl.STATIC_DRAW
      @elapsed = 0