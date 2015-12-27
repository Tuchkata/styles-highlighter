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
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFirstStyle': => @markFirstStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markSecondStyle': => @markSecondStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markThirdStyle': => @markThirdStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFourthStyle': => @markFourthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFifthStyle': => @markFifthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFirstStyle': => @clearFirstStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearSecondStyle': => @clearSecondStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearThirdStyle': => @clearThirdStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFourthStyle': => @clearFourthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFifthStyle': => @clearFifthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearAllStyles': => @clearAllStyles()

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
    console.log 'Styles highlighter was toggled! Getting Editor'

    @markSelection()

    if @stylesHighlighterView.disable
      @stylesHighlighterView.enable()
    else
      @stylesHighlighterView.disable()

  markSelection: ->
    editor = atom.workspace.getActiveTextEditor();
    console.log 'Got editor'
    return unless editor
    console.log 'checking if we have a selection'
    return if editor.getLastSelection().isEmpty()

    selectedText = editor.getSelectedText()
    console.log "Highlighting all occurences of #{selectedText}"

    range = [[0, 0], editor.getEofBufferPosition()]

    occurences = 0;
    editor.scanInBufferRange new RegExp(selectedText, 'g'), range,
      (result) =>
        occurences +=1
        marker = editor.markBufferRange(result.range)
        editor.decorateMarker(marker, {type: 'highlight', class: 'highlighted'})
        console.log 'added marker for occurence'

    console.log "Found #{selectedText} #{occurences} times in document"


  markFirstStyle: ->
    @markSelection()

  markSecondStyle: ->
    @markSelection()

  markThirdStyle: ->
    @markSelection()

  markFourthStyle: ->
    @markSelection()

  markFifthStyle: ->
    @markSelection()

  clearFirstStyle: ->

  clearSecondStyle: ->

  clearThirdStyle: ->

  clearFourthStyle: ->

  clearFifthStyle: ->

  clearAllStyles: ->
