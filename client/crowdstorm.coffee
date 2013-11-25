Deps.autorun ->
  taskId = Session.get("taskId")
  Meteor.subscribe("response", taskId)

Handlebars.registerHelper "promptText", ->
  Prompts.findOne()?.text

Template.task2.inputTypes = ->
  Tasks.findOne(@taskId).inputs if @taskId?

Template.task2.taskText = ->
  Tasks.findOne(@taskId).text if @taskId?

Template.task2.itemSet = ->
  prompt = Prompts.findOne()

  Items.find
    prompt: prompt._id
    type: ''+@

Template.ideaBox.currentIdeas = ->
  # Publications don't give other stuff
  Items.find
    userId: Interactions.findOne().userId
    taskId: Session.get("taskId")

Template.ideaBox.events =
  "click .action-idea-delete": ->
    Items.remove @_id
  "submit form": (e, tmpl) ->
    e.preventDefault()
    $el = $(tmpl.find("input"))

    Items.insert
      prompt: Prompts.findOne()._id
      userId: Interactions.findOne().userId
      taskId: Session.get("taskId")
      text: $el.val()

    $el.val('')

