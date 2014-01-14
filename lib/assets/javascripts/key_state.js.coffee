class @KeyState
  @currentlyPressedKeys = []

  @handleKeyDown: (event) ->
    KeyState.currentlyPressedKeys[event.keyCode] = true

  @handleKeyUp: (event) ->
    KeyState.currentlyPressedKeys[event.keyCode] = false

  @load: ->
    document.onkeydown = KeyState.handleKeyDown
    document.onkeyup = KeyState.handleKeyUp