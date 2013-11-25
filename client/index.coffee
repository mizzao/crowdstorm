login = ->
  return if Meteor.userId()
  bootbox.prompt "Please enter a username", (username) ->
    Meteor.insecureUserLogin(username) if username?

# Start initial login after stuff loaded
Meteor.startup ->
  Meteor.setTimeout login, 50

# Always request username if logged out
Deps.autorun(login)

Router.configure
  layoutTemplate: 'layout'

checkLogin = ->
  unless Meteor.user()
    @render("login")
    @stop()

Router.map ->
  @route 'home',
    path: '/'
  @route 'task1',
    before: ->
      checkLogin.call @
      Session.set("taskId", null)
  @route 'task2',
    data: -> Interactions.findOne()
    before: ->
      checkLogin.call @
      Session.set("taskId", @getData()?.taskId)
  @route 'diversity',
    before: ->
      checkLogin.call @
  @route 'done'

# The disconnect dialog
Deps.autorun ->
  status = Meteor.status()

  if status.connected and disconnectDialog?
    disconnectDialog.modal("hide")
    disconnectDialog = null
    return

  if !status.connected and disconnectDialog is null
    disconnectDialog = bootbox.dialog(
                                     """<h3>You have been disconnected from the server.
         Please check your Internet connection.</h3>""")
    return
