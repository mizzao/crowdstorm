login = ->
  return if Meteor.userId()
  bootbox.prompt "Please enter a username", (username) ->
    Meteor.insecureUserLogin(username) if username?

# Start initial login after stuff loaded
Meteor.startup ->
  # login()
  Meteor.setTimeout login, 500

# Always request username if logged out
Deps.autorun(login)

Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
  @route 'nullTask',
    before: -> Session.set("taskId", null)
  @route 'testTask',
    data: -> Interactions.findOne()
    before: -> Session.set("taskId", @getData()?.taskId)
  @route 'done'

Deps.autorun ->
  taskId = Session.get("taskId")
  Meteor.subscribe("response", taskId)

Handlebars.registerHelper "promptText", ->
  Prompts.findOne()?.text

Template.testTask.taskText = ->
  Tasks.findOne(@taskId).text if @taskId?

Template.testTask.twoIdeas = ->
  Tasks.findOne(@taskId).inputs > 1 if @taskId?


Template.testTask.firstIdea = ->
  interaction = Interactions.findOne()
  return unless interaction?
  Items.findOne(interaction.ideaIds[0])?.text

Template.testTask.secondIdea = ->
  interaction = Interactions.findOne()
  return unless interaction?
  Items.findOne(interaction.ideaIds[1])?.text

Template.ideaBox.currentIdeas = ->
  Responses.find()

Template.ideaBox.events =
  "submit form": (e, tmpl) ->
    e.preventDefault()
    $el = $(tmpl.find("input"))

    Responses.insert
      "interaction": Interactions.findOne()._id
      "taskId": Session.get("taskId")
      "text": $el.val()

    $el.val('')
