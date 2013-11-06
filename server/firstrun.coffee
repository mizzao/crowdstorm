# Put our 5 questions into the Tasks collection
initCollection = (collection, items) ->
  Meteor.startup ->
    return if collection.find().count() > 0
    for item in items
      collection.insert item
    return

initCollection Tasks, [
    text: "Come up with something similar to this idea"
    inputs: 1
  ,
    text: "Come up with something different from this idea"
    inputs: 1
  ,
    text: "Come up with something similar to both these ideas"
    inputs: 2
  ,
    text: "Come up with something different from both these ideas"
    inputs: 2
  ,
    text: "Come up with something similar to the idea on the left and different from the one on the right"
    inputs: 2
  ]


initCollection Prompts, [{text: "How do we create a greener and greater New York City?"}]

# Load a couple of ideas
initCollection Items, [
    text: "Allow access to drinking water sampling stations to let people refill reusable bottles."
    type: "transportation"
  ,
    text: "Promote cycling by installing safe bike lanes"
    type: "transportation"
  ,
    text: "Improve schools in all districts so kids don't travel so far"
    type: "education"
  ,
    text: "Promote the use of solar energy using the latest technology on all high-rise buildings"
    type: "energy"
  ,
    text: "Replace sodium vapor street lights with LED or other energy-saving lights"
    type: "technology"
  ,
    text: "Preserve natural areas and woodlands as natural parks"
    type: "environment"
  ]