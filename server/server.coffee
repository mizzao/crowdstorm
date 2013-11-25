Meteor.publish null, ->
  [
    Prompts.find(),
    Tasks.find(),
  ]

randomIdFromCollection = (collection) ->
  _.sample(collection.find().fetch())._id

randomIdsFromCollection = (collection, n) ->
  item._id for item in _.sample(collection.find().fetch(), n)

# Always subscribe to the current interaction
Meteor.publish null, ->
  userId = @userId

  # Create interaction if none exists
  interaction = Interactions.findOne(user: userId)
  unless interaction
    interaction =
      user: userId
      taskId: randomIdFromCollection(Tasks)
      # Always pick 2 ideas, even if we don't need both.
      ideaIds: randomIdsFromCollection(Items, 2)
    Interactions.insert interaction

  return [
    Interactions.find(userId),
    Items.find(_id: {$in: interaction.ideaIds})
  ]

Meteor.publish "response", (taskId) ->
  userId = @userId
  Responses.find
    interaction: userId
    taskId: taskId

Responses._ensureIndex
  interaction: 1
