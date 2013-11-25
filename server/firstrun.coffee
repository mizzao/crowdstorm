# Put our 5 questions into the Tasks collection
initCollection = (collection, items) ->
  return if collection.find().count() > 0
  return collection.insert(item) for item in items

Meteor.startup -> initCollection Tasks,
  [
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

Meteor.startup ->
  [nycPrompt, csPrompt]= initCollection Prompts, [
    text: "How do we create a greener and greater New York City?"
  ,
    text: "How can we improve computer science graduate student life at Harvard?"
  ]

  initCollection Items, [
    text: "Allow access to drinking water sampling stations to let people refill reusable bottles."
    prompt: nycPrompt
  ,
    text: "Promote cycling by installing safe bike lanes"
    prompt: nycPrompt
  ,
    text: "Improve schools in all districts so kids don't travel so far"
    prompt: nycPrompt
  ,
    text: "Promote the use of solar energy using the latest technology on all high-rise buildings"
    prompt: nycPrompt
  ,
    text: "Replace sodium vapor street lights with LED or other energy-saving lights"
    prompt: nycPrompt
  ,
    text: "Preserve natural areas and woodlands as natural parks"
    prompt: nycPrompt
  ]
