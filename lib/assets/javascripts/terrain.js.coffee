class @Terrain
  contructor: (@width, @height, @blockScale, @heightScale, @effect, @heightLevel, @heightMap)
    @vertexCountX = @width
    @vertexCountZ = @height
  
    @GenerateTerrainMesh()

  draw: (camera) ->
    gl.disable gl.BLEND
    gl.useProgram @effect.shaderProgram
    @setEffectParams camera.pMatrix, camera.vMatrix, @effect.shaderProgram
    gl.drawElements gl.TRIANGLES, @vertexIndexBuffer.numItems, gl.UNSIGNED_SHORT, 0

  GenerateTerrainMesh: =>
    try
      @numVertices = @vertexCountX * @vertexCountZ
      @numTriangles = (@vertexCountX - 1) * (@vertexCountZ - 1) * 2
      indices = @GenerateTerrainIndices()
      vertices = @GenerateTerrainVertices(indices)
      @CreateBuffer vertices, indices
    catch e
      alert "In terrain mesh:" + e

  GenerateTerrainIndices: =>
    numIndices = @numTriangles * 3
    indices = new Array(numIndices)
    indicesCount = 0
    i = 0

    while i < (@vertexCountZ - 1)
      j = 0

      while j < (@vertexCountX - 1)
        index = j + i * @vertexCountZ
        indices[indicesCount++] = index
        indices[indicesCount++] = index + 1
        indices[indicesCount++] = index + @vertexCountX + 1
        indices[indicesCount++] = index + @vertexCountX + 1
        indices[indicesCount++] = index + @vertexCountX
        indices[indicesCount++] = index
        j++
      i++
    indices

  GenerateTerrainVertices: (terrainIndices) =>
    halfTerrainWidth = (@vertexCountX - 1) * @blockScale * 0.5
    halfTerrainDepth = (@vertexCountZ - 1) * @blockScale * 0.5
    
    # Texture coordinates
    tu = 0
    tv = 0
    tuDerivative = 1.0 / (@vertexCountX - 1)
    tvDerivative = 1.0 / (@vertexCountZ - 1)
    vertexCount = 0
    vertices = new Array(@vertexCountX * @vertexCountZ)
    
    # Set vertices position and texture coordinate
    i = halfTerrainDepth * (-1)

    while i <= halfTerrainDepth
      tu = 0
      j = halfTerrainWidth * (-1)

      while j <= halfTerrainWidth
        vertices[vertexCount] =
          Position: [j, @heightMap[vertexCount] * @heightScale, i]
          TextureCoordinate: [tu + j / (@blockScale * 40), tv + i / (@blockScale * 40)]
          Normal: vec3.create()

        tu += tuDerivative
        vertexCount++
        j += @blockScale
      tv += tvDerivative
      i += @blockScale
    
    # Generate vertice's normal, tangent and binormal
    @GenerateTerrainNormals vertices, terrainIndices
    vertices

  CreateBuffer: (vertices, indices) =>
    realVertices = []
    realTextureCoor = []
    realNormal = []
    i = 0

    while i < vertices.length
      pos = vertices[i].Position
      coor = vertices[i].TextureCoordinate
      norm = vertices[i].Normal
      realVertices[i * 3] = pos[0]
      realVertices[i * 3 + 1] = pos[1]
      realVertices[i * 3 + 2] = pos[2]
      realTextureCoor[i * 2] = coor[0]
      realTextureCoor[i * 2 + 1] = coor[1]
      realNormal[i * 3] = norm[0]
      realNormal[i * 3 + 1] = norm[1]
      realNormal[i * 3 + 2] = norm[2]
      i++
    @vertexTextureCoordBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(realTextureCoor), gl.STATIC_DRAW
    @vertexTextureCoordBuffer.itemSize = 2
    @vertexTextureCoordBuffer.numItems = realTextureCoor.length / 2
    @vertexPositionBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(realVertices), gl.STATIC_DRAW
    @vertexPositionBuffer.itemSize = 3
    @vertexPositionBuffer.numItems = realVertices.length / 3
    @vertexIndexBuffer = gl.createBuffer()
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer
    gl.bufferData gl.ELEMENT_ARRAY_BUFFER, new Uint16Array(indices), gl.STATIC_DRAW
    @vertexIndexBuffer.itemSize = 1
    @vertexIndexBuffer.numItems = indices.length
    @vertexNormalBuffer = gl.createBuffer()
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexNormalBuffer
    gl.bufferData gl.ARRAY_BUFFER, new Float32Array(realNormal), gl.STATIC_DRAW
    @vertexNormalBuffer.itemSize = 3
    @vertexNormalBuffer.numItems = realNormal.length / 3

  GetHeight: (positionX, positionZ) =>
    height = 0.0
    return height  unless @heightMap?
    halfTerrainWidth = (@vertexCountX - 1) * @blockScale * 0.5
    halfTerrainDepth = (@vertexCountZ - 1) * @blockScale * 0.5
    
    # Get the position of the object in the terrain grid
    positionInGrid = [positionX + halfTerrainWidth, positionZ + halfTerrainDepth]
    
    # Calculate the start block position
    blockPosition = [positionInGrid[0] / @blockScale, positionInGrid[1] / @blockScale]
    blockPosition[0] = 0  if blockPosition[0] < 0
    blockPosition[0] = (@vertexCountX - 2)  if blockPosition[0] >= (@vertexCountX - 1)
    blockPosition[1] = 0  if blockPosition[1] < 0
    blockPosition[1] = (@vertexCountZ - 2)  if blockPosition[1] >= (@vertexCountZ - 1)
    
    # Check if the object is inside the grid
    if blockPosition[0] >= 0 and blockPosition[0] < (@vertexCountX - 1) and blockPosition[1] >= 0 and blockPosition[1] < (@vertexCountZ - 1)
      blockOffset = [blockPosition[0] - Math.floor(blockPosition[0]), blockPosition[1] - Math.floor(blockPosition[1])]
      
      # Get the height of the four vertices of the grid block
      vertexIndex = Math.floor(blockPosition[0]) + Math.floor(blockPosition[1]) * @vertexCountX
      height1 = @heightMap[vertexIndex + 1]
      height2 = @heightMap[vertexIndex]
      height3 = @heightMap[vertexIndex + @vertexCountX + 1]
      height4 = @heightMap[vertexIndex + @vertexCountX]
      
      # Bottom triangle
      heightIncX = undefined
      heightIncY = undefined
      if blockOffset[0] > blockOffset[1]
        heightIncX = height1 - height2
        heightIncY = height3 - height1
      
      # Top triangle
      else
        heightIncX = height3 - height4
        heightIncY = height4 - height2
      
      # Linear interpolation to find the height inside the triangle
      lerpHeight = height2 + heightIncX * blockOffset[0] + heightIncY * blockOffset[1]
      height = lerpHeight * @heightScale
    height

  GenerateTerrainNormals: (vertices, indices) =>
    i = 0

    while i < indices.length
      v1 = vertices[indices[i]].Position
      v2 = vertices[indices[i + 1]].Position
      v3 = vertices[indices[i + 2]].Position
      vu = vec3.create()
      vec3.subtract v3, v1, vu
      vt = vec3.create()
      vec3.subtract v2, v1, vt
      normal = vec3.create()
      vec3.cross vu, vt, normal
      vec3.normalize normal
      vec3.add vertices[indices[i]].Normal, normal
      vec3.add vertices[indices[i + 1]].Normal, normal
      vec3.add vertices[indices[i + 2]].Normal, normal
      i += 3
    i = 0

    while i < vertices.length
      vec3.normalize vertices[i].Normal
      i++

  setEffectParams: (pMatrix, vMatrix, shaderProgram) =>
    unless shaderProgram.isReady?
      shaderProgram.vertexPositionAttribute = gl.getAttribLocation(shaderProgram, "aVertexPosition")
      gl.enableVertexAttribArray shaderProgram.vertexPositionAttribute
      shaderProgram.textureCoordAttribute = gl.getAttribLocation(shaderProgram, "aTextureCoord")
      gl.enableVertexAttribArray shaderProgram.textureCoordAttribute
      shaderProgram.vertexNormalAttribute = gl.getAttribLocation(shaderProgram, "aVertexNormal")
      gl.enableVertexAttribArray shaderProgram.vertexNormalAttribute
      shaderProgram.pMatrixUniform = gl.getUniformLocation(shaderProgram, "uPMatrix")
      shaderProgram.vMatrixUniform = gl.getUniformLocation(shaderProgram, "uVMatrix")
      shaderProgram.samplerUniform00 = gl.getUniformLocation(shaderProgram, "uSampler00")
      shaderProgram.samplerUniform01 = gl.getUniformLocation(shaderProgram, "uSampler01")
      shaderProgram.samplerUniform02 = gl.getUniformLocation(shaderProgram, "uSampler02")
      shaderProgram.samplerUniform03 = gl.getUniformLocation(shaderProgram, "uSampler03")
      shaderProgram.min00 = gl.getUniformLocation(shaderProgram, "min00")
      shaderProgram.max00 = gl.getUniformLocation(shaderProgram, "max00")
      shaderProgram.min01 = gl.getUniformLocation(shaderProgram, "min01")
      shaderProgram.max01 = gl.getUniformLocation(shaderProgram, "max01")
      shaderProgram.min02 = gl.getUniformLocation(shaderProgram, "min02")
      shaderProgram.max02 = gl.getUniformLocation(shaderProgram, "max02")
      shaderProgram.min03 = gl.getUniformLocation(shaderProgram, "min03")
      shaderProgram.max03 = gl.getUniformLocation(shaderProgram, "max03")
      shaderProgram.ambientColorUniform = gl.getUniformLocation(shaderProgram, "uAmbientColor")
      shaderProgram.pointLightingLocationUniform = gl.getUniformLocation(shaderProgram, "uPointLightingLocation")
      shaderProgram.pointLightingColorUniform = gl.getUniformLocation(shaderProgram, "uPointLightingColor")
      shaderProgram.isReady = true
    gl.uniformMatrix4fv shaderProgram.pMatrixUniform, false, pMatrix
    gl.uniformMatrix4fv shaderProgram.vMatrixUniform, false, vMatrix
    ambient =
      R: 0.2
      G: 0.2
      B: 0.2

    point =
      R: 1
      G: 1
      B: 1

    
    #var lightPosition = {X:-1500,Y:1000,Z:-1500}
    lightPosition =
      X: 0
      Y: 1000
      Z: 0

    gl.uniform3f shaderProgram.ambientColorUniform, ambient.R, ambient.G, ambient.B
    gl.uniform3f shaderProgram.pointLightingLocationUniform, lightPosition.X, lightPosition.Y, lightPosition.Z
    gl.uniform3f shaderProgram.pointLightingColorUniform, point.R, point.G, point.B
    gl.uniform1f shaderProgram.min00, @heightlevel[0].min
    gl.uniform1f shaderProgram.max00, @heightlevel[0].max
    gl.uniform1f shaderProgram.min01, @heightlevel[1].min
    gl.uniform1f shaderProgram.max01, @heightlevel[1].max
    gl.uniform1f shaderProgram.min02, @heightlevel[2].min
    gl.uniform1f shaderProgram.max02, @heightlevel[2].max
    gl.uniform1f shaderProgram.min03, @heightlevel[3].min
    gl.uniform1f shaderProgram.max03, @heightlevel[3].max
    gl.activeTexture gl.TEXTURE0
    gl.bindTexture gl.TEXTURE_2D, @heightlevel[0].texture
    gl.uniform1i shaderProgram.samplerUniform00, 0
    gl.activeTexture gl.TEXTURE1
    gl.bindTexture gl.TEXTURE_2D, @heightlevel[1].texture
    gl.uniform1i shaderProgram.samplerUniform01, 1
    gl.activeTexture gl.TEXTURE2
    gl.bindTexture gl.TEXTURE_2D, @heightlevel[2].texture
    gl.uniform1i shaderProgram.samplerUniform02, 2
    gl.activeTexture gl.TEXTURE3
    gl.bindTexture gl.TEXTURE_2D, @heightlevel[3].texture
    gl.uniform1i shaderProgram.samplerUniform03, 3
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexPositionBuffer
    gl.vertexAttribPointer shaderProgram.vertexPositionAttribute, @vertexPositionBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexTextureCoordBuffer
    gl.vertexAttribPointer shaderProgram.textureCoordAttribute, @vertexTextureCoordBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ARRAY_BUFFER, @vertexNormalBuffer
    gl.vertexAttribPointer shaderProgram.vertexNormalAttribute, @vertexNormalBuffer.itemSize, gl.FLOAT, false, 0, 0
    gl.bindBuffer gl.ELEMENT_ARRAY_BUFFER, @vertexIndexBuffer

  GetPosition: (row, column) =>
    row = 0  if row < 0
    column = 0  if column < 0
    row = @width  if row > @width
    column = @height  if column > @height
    halfTerrainWidth = (@vertexCountX - 1) * @blockScale * 0.5
    halfTerrainDepth = (@vertexCountZ - 1) * @blockScale * 0.5
    position =
      x: row * @blockScale - halfTerrainWidth
      z: column * @blockScale - halfTerrainDepth

    position.y = @GetHeight(position.x, position.z)
    position