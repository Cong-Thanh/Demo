class @Content
  constructor: (@files) ->
    tasks = []
    for file in files
      do (file) ->
        if file.match /(\w|\W)+(.jpg|.png)/
          tasks.push (callback) ->
            texture = gl.createTexture()
            texture.image = new Image()
            texture.image.onload = ->
              gl.pixelStorei gl.UNPACK_FLIP_Y_WEBGL, true
              gl.bindTexture gl.TEXTURE_2D, texture
              gl.texImage2D gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, texture.image
              gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR
              gl.texParameteri gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR_MIPMAP_NEAREST
              gl.generateMipmap gl.TEXTURE_2D
              gl.bindTexture gl.TEXTURE_2D, null
              result = {}
              result[file] = texture
              callback null, result
            texture.image.src = "assets/TownHall.jpg"
        else
          tasks.push (callback) ->
            $.get "assets/basic.txt", (data) ->
              result = {}
              result[file] = data
              callback null, result

    @content = {}
    async.parallel tasks, (err, results) =>
      for result in results
        do (result) =>
          @content = $.extend {}, @content, result