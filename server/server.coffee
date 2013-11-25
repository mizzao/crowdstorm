Meteor.publish null, ->
  Prompts.find(active: true)

# TODO these are inefficient. Implement our own reservoir sampling.
randomDoc = (cursor) ->
  _.sample cursor.fetch()

randomDocSet = (cursor, n) ->
  _.sample cursor.fetch(), n

# Always subscribe to the current interaction (treatment)
Meteor.publish null, ->
  return unless @userId

  # Create interaction for this user if none exists
  interaction = Interactions.findOne({userId: @userId})
  unless interaction
    taskCursor = Tasks.find(active: true)

    # XXX DIRTY HACKY CODE!
    interaction =
      userId: @userId
      taskId: taskCursor.fetch()[Meteor.users.find().count() % taskCursor.count()]._id

    Interactions.insert interaction

  prompt = Prompts.findOne(active: true)
  task = Tasks.findOne(interaction.taskId)

  return [
    Interactions.find
      userId: @userId
  ,
    Tasks.find interaction.taskId
  ,
    Items.find
      prompt: prompt._id
      type: { $in: task.inputs }
  ]

Meteor.publish "response", (taskId) ->
  userId = @userId
  Items.find
    # could put prompts here
    userId: userId
    taskId: taskId

Interactions._ensureIndex
  userId: 1

Meteor.publish "diversity", ->
  sub = this
  prompt = Prompts.findOne(active: true)
  # Generate random 3-tuples of ideas
  ids = (doc._id for doc in randomDocSet(Items.find(prompt: prompt._id), 3))
  Items.find(_id: {$in: ids}).forEach (doc) ->
    sub.added("randomItems", doc._id, doc)
  sub.ready()
