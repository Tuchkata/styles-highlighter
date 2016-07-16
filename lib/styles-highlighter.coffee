StylesHighlighterView = require './styles-highlighter-view'
{CompositeDisposable} = require 'atom'

module.exports = StylesHighlighter =
  stylesHighlighterView: null
  modalPanel: null
  subscriptions: null

  # the method called when the package is activated
  activate: (state) ->
    @style1Highlights = []
    @style2Highlights = []
    @style3Highlights = []
    @style4Highlights = []
    @style5Highlights = []
    @style6Highlights = []
    @style7Highlights = []
    @style8Highlights = []
    @style9Highlights = []
    @style10Highlights = []

    @stylesHighlighterView = new StylesHighlighterView(state.stylesHighlighterViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @stylesHighlighterView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFirstStyle': => @markFirstStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markSecondStyle': => @markSecondStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markThirdStyle': => @markThirdStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFourthStyle': => @markFourthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markFifthStyle': => @markFifthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markSixthStyle': => @markSixthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markSeventhStyle': => @markSeventhStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markEighthStyle': => @markEighthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markNinethStyle': => @markNinethStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:markTenthStyle': => @markTenthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFirstStyle': => @clearFirstStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearSecondStyle': => @clearSecondStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearThirdStyle': => @clearThirdStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFourthStyle': => @clearFourthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearFifthStyle': => @clearFifthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearSixthStyle': => @clearSixthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearSeventhStyle': => @clearSeventhStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearEighthStyle': => @clearEighthStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearNinethStyle': => @clearNinethStyle()
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles-highlighter:clearTenthStyle': => @clearTenthStyle()
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

  markSelection: (highlights, style)->
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
        decoration = editor.decorateMarker(marker, {type: 'highlight', class: style})
        console.log 'added marker for occurence'
        highlights.push(marker)

    console.log "Found #{selectedText} #{occurences} times in document"

  clearMarkers: (highlights)->
    for marker in highlights
      marker.destroy()
      marker = null
      console.log "Marker destroyed"

  markFirstStyle: ->
    @markSelection(@style1Highlights, 'highlighStyle1')

  markSecondStyle: ->
    @markSelection(@style2Highlights, 'highlighStyle2')

  markThirdStyle: ->
    @markSelection(@style3Highlights, 'highlighStyle3')

  markFourthStyle: ->
    @markSelection(@style4Highlights, 'highlighStyle4')

  markFifthStyle: ->
    @markSelection(@style5Highlights, 'highlighStyle5')

  markSixthStyle: ->
    @markSelection(@style6Highlights, 'highlighStyle6')

  markSeventhStyle: ->
    @markSelection(@style7Highlights, 'highlighStyle7')

  markEighthStyle: ->
    @markSelection(@style8Highlights, 'highlighStyle8')

  markNinethStyle: ->
    @markSelection(@style9Highlights, 'highlighStyle9')

  markTenthStyle: ->
    @markSelection(@style10Highlights, 'highlighStyle10')

  clearFirstStyle: ->
    @clearMarkers(@style1Highlights)

  clearSecondStyle: ->
    @clearMarkers(@style2Highlights)

  clearThirdStyle: ->
    @clearMarkers(@style3Highlights)

  clearFourthStyle: ->
    @clearMarkers(@style4Highlights)

  clearFifthStyle: ->
    @clearMarkers(@style5Highlights)

  clearSixthStyle: ->
    @clearMarkers(@style6Highlights)

  clearSeventhStyle: ->
    @clearMarkers(@style7Highlights)

  clearEighthStyle: ->
    @clearMarkers(@style8Highlights)

  clearNinethStyle: ->
    @clearMarkers(@style9Highlights)

  clearTenthStyle: ->
    @clearMarkers(@style10Highlights)

  clearAllStyles: ->
    @clearMarkers(@style1Highlights)
    @clearMarkers(@style2Highlights)
    @clearMarkers(@style3Highlights)
    @clearMarkers(@style4Highlights)
    @clearMarkers(@style5Highlights)
    @clearMarkers(@style6Highlights)
    @clearMarkers(@style7Highlights)
    @clearMarkers(@style8Highlights)
    @clearMarkers(@style9Highlights)
    @clearMarkers(@style10Highlights)
