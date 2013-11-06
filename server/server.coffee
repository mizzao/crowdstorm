Meteor.publish null, ->
  [
    Prompts.find(),
    Tasks.find(),
  ]

randomIdFromCollection = (collection) ->
  _.sample(collection.find().fetch())._id

randomIdsFromCollection = (collection, n) ->
  for item in _.sample(collection.find().fetch(), n)
    item._id

# Always subscribe to the current interaction
Meteor.publish null, ->
  sessionId = @_session.id

  # Create interaction if none exists
  interaction = Interactions.findOne(sessionId)
  unless interaction
    interaction =
      _id: sessionId
      taskId: randomIdFromCollection(Tasks)
      # Always pick 2 ideas, even if we don't need both.
      ideaIds: randomIdsFromCollection(Items, 2)
    Interactions.insert interaction

  return [
    Interactions.find(sessionId),
    Items.find(_id: {$in: interaction.ideaIds})
  ]


Meteor.publish "response", (taskId) ->
  sessionId = @_session.id
  Responses.find
    interaction: sessionId
    taskId: taskId


Responses._ensureIndex
  interaction: 1
