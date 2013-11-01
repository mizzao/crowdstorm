Meteor.publish null, ->
  [
    Prompts.find(),
    Tasks.find(),
    Items.find()
  ]

# Always subscribe to the current interaction
Meteor.publish null, ->
  sessionId = @_session.id

  # Create interaction if none exists
  unless Interactions.findOne(sessionId)
    # Pick this user a random task
    tasks = Tasks.find().fetch()
    randomTaskId = tasks[_.random(0, tasks.length-1)]._id

    Interactions.insert
      _id: sessionId
      taskId: randomTaskId
      # TODO pick a random vector if more than 1 input

  return Interactions.find(sessionId)

Meteor.publish "response", (taskId) ->
  sessionId = @_session.id
  Responses.find
    interaction: sessionId
    taskId: taskId

Responses._ensureIndex
  interaction: 1
