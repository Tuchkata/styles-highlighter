StylesHighlighterView = require './styles-highlighter-view'
{CompositeDisposable} = require 'atom'

module.exports = StylesHighlighter =
  stylesHighlighterView: null
  modalPanel: null
  subscriptions: null

  # the method called when the package is activated
  activate: (state) ->
    @stylesHighlighterView = new StylesHighlighterView(state.stylesHighlighterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @stylesHighlighterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:toggle': => @toggle()

  # called when the windows is shutting down. If any files or resources are caught
  # by the package, they should be released here
  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @stylesHighlighterView.destroy()

  # called when the window is shutting down in order to save the state of the package
  # to a JSON object
  serialize: ->
    stylesHighlighterViewState: @stylesHighlighterView.serialize()

  toggle: ->
    console.log 'Styles highlighter was toggled!'

    if @stylesHighlighterView.disable
      @stylesHighlighterView.enable()
    else
      @stylesHighlighterView.disable()

  markFirstStyle: ->
    editor = @getActiveEditor()
    return unless editor
    return if editor.getLastSelection().isEmpty()

  markSecondStyle: ->

  markThirdStyle: ->

  markFourthStyle: ->

  markFifthStyle: ->

  clearFirstStyle: ->

  clearSecondStyle: ->

  clearThirdStyle: ->

  clearFourthStyle: ->

  clearFifthStyle: ->

  clearAllStyles: ->
