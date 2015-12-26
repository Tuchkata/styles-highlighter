module.exports =
class StylesHighlighterView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('styles-highlighter')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The Styles Highlighter package is started"
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  enable: ->
    @disabled = false

  disable: ->
    @disabled = true
