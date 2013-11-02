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


firstIndex = -1

Template.testTask.firstIdea = ->
  numIdeas = Items.find().count()
  firstIndex = Math.floor(Math.random() * numIdeas)
  console.log "first" + firstIndex
  Items.find().fetch()[firstIndex]?.text

Template.testTask.secondIdea = ->
  numIdeas = Items.find().count()
  console.log numIdeas
  secondIndex = Math.floor(Math.random() * numIdeas)
  while (secondIndex is firstIndex)
    secondIndex = Math.floor(Math.random() * numIdeas)
  console.log "second" + secondIndex
  Items.find().fetch()[secondIndex]?.text

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
