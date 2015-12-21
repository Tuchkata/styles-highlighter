StylesHighlighterView = require './styles-highlighter-view'
{CompositeDisposable} = require 'atom'

module.exports = StylesHighlighter =
  stylesHighlighterView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @stylesHighlighterView = new StylesHighlighterView(state.stylesHighlighterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @stylesHighlighterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @stylesHighlighterView.destroy()

  serialize: ->
    stylesHighlighterViewState: @stylesHighlighterView.serialize()

  toggle: ->
    console.log 'Styles highlighter was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
