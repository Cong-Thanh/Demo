class @BillboardModel
  constructor: (@texture, @effect) ->  
    data = {}
    data.vertexTextureCoords = [
      0.0
      0.0
      1.0
      0.0
      1.0
      1.0
      0.0
      1.0
    ]
    data.vertexPositions = [
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
      0.0
    ]
    data.indices = [
      0
      1
      2
      0
      2
      3
    ]
    @vertexTextureCoordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(data.vertexTextureCoords), gl.STATIC_DRAW
    @vertexTextureCoordBuffer.itemSize = 2
    @vertexTextureCoordBuffer.numItems = data.vertexTextureCoords.length / 2
    @vertexPositionBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(data.vertexPositions), gl.STATIC_DRAW
    @vertexPositionBuffer.itemSize = 3
    @vertexPositionBuffer.numItems = data.vertexPositions.length / 3
    @vertexIndexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(data.indices), gl.STATIC_DRAW
    @vertexIndexBuffer.itemSize = 1
    @vertexIndexBuffer.numItems = data.indices.length
  
  draw: (camera, wTranslateMatrix, scaleWidth, scaleHeight, wRotateMatrix) =>
    gl.useProgram @effect.shaderProgram
    @setEffectParams camera.pMatrix, camera.vMatrix, wTranslateMatrix, scaleWidth, scaleHeight, @effect.shaderProgram, camera.position, camera.upvec, wRotateMatrix
    gl.drawElements gl.TRIANGLES, @vertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0

  setEffectParams: (pMatrix, vMatrix, wTranslateMatrix, scaleWidth, scaleHeight, shaderProgram, campos, upvec, wRotateMatrix) =>
    unless shaderProgram.isReady?
      shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition")
      gl.enableVertexAttribArray shaderProgram.vertexPositionAttribute
      shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord")
      gl.enableVertexAttribArray shaderProgram.textureCoordAttribute
      shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
      shaderProgram.vMatrixUniform = gl.getUniformLocation(shaderProgram, "uVMatrix")
      shaderProgram.wTranslateMatrixUniform = gl.getUniformLocation(shaderProgram, "uWTranslateMatrix")
      shaderProgram.wRotateMatrixUniform = gl.getUniformLocation(shaderProgram, "uWRotateMatrix")
      shaderProgram.samplerUniform = gl.getUniformLocation(shaderProgram, "uSampler")
      shaderProgram.wCameraPosUniform = gl.getUniformLocation(shaderProgram, "camPos")
      shaderProgram.wUpVectorUniform = gl.getUniformLocation(shaderProgram, "upVector")
      shaderProgram.wScaleWidthUniform = gl.getUniformLocation(shaderProgram, "scaleWidth")
      shaderProgram.wScaleHeightUniform = gl.getUniformLocation(shaderProgram, "scaleHeight")
      shaderProgram.isReady = true
    gl.uniformMatrix4fv shaderProgram.pMatrixUniform, false, pMatrix
    gl.uniformMatrix4fv shaderProgram.vMatrixUniform, false, vMatrix
    gl.uniformMatrix4fv shaderProgram.wTranslateMatrixUniform, false, wTranslateMatrix
    gl.uniformMatrix4fv shaderProgram.wRotateMatrixUniform, false, wRotateMatrix
    gl.uniform3f shaderProgram.wCameraPosUniform, campos.x, campos.y, campos.z
    gl.uniform3f shaderProgram.wUpVectorUniform, upvec.x, upvec.y, upvec.z
    gl.uniform1f shaderProgram.wScaleWidthUniform, scaleWidth
    gl.uniform1f shaderProgram.wScaleHeightUniform, scaleHeight
    gl.activeTexture gl.TEXTURE0
    gl.bindTexture gl.TEXTURE_2D, @texture
    gl.uniform1i shaderProgram.samplerUniform, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.vertexAttribPointer shaderProgram.vertexPositionAttribute, @vertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.vertexAttribPointer shaderProgram.textureCoordAttribute, @vertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer