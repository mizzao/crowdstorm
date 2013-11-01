Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
  @route 'nullTask',
    before: -> Session.set("taskId", null)
  @route 'testTask',
    before: -> Session.set("taskId", Interactions.findOne()?.taskId)
    data: -> Interactions.findOne()
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
  Items.find().fetch()[0]?.text

Template.testTask.secondIdea = ->
  Items.find().fetch()[1]?.text

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
