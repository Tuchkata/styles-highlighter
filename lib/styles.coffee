StylesView = require './styles-view'
{CompositeDisposable} = require 'atom'

module.exports = Styles =
  stylesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @stylesView = new StylesView(state.stylesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @stylesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'styles:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @stylesView.destroy()

  serialize: ->
    stylesViewState: @stylesView.serialize()

  toggle: ->
    console.log 'Styles was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
