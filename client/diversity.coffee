Template.diversity.randomIdeas = ->
  RandomItems.find()

Template.diversity.created = ->
  @sub = Meteor.subscribe("diversity")

Template.diversity.events =
  "click .action-select-outlier": (e, tp) ->
    Diversity.insert
      items: _.pluck RandomItems.find().fetch(), "_id"
      outlier: @_id

    # Get some more
    tp.sub.stop()
    tp.sub = Meteor.subscribe("diversity")

Template.diversity.destroyed = ->
  @sub.stop()
