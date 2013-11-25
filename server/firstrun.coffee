# Put our 5 questions into the Tasks collection
initCollection = (collection, items) ->
  return if collection.find().count() > 0
  collection.insert(item) for item in items

Meteor.startup ->
  initCollection Tasks, [
    text: "Come up with something similar to this idea"
    inputs: 1
  ,
    text: "Come up with something different from this idea"
    inputs: 1
  ,
    text: "Come up with ideas that have <u>similar characteristics to these ideas</u>"
    inputs: [ "sim" ]
    active: true
  ,
    text: "Come up with ideas that <u>avoids characteristics of these ideas</u>"
    inputs: [ "diff" ]
    active: true
  ,
    text: "Come up with ideas that have <u>similar characteristics to the ideas on the left</u> and <u>avoids characteristics of ideas on the right</u>"
    inputs: [ "sim", "diff" ]
    active: true
  ]

Meteor.startup ->
  ids = initCollection Prompts, [
    text: "How do we create a greener and greater New York City?"
  ,
    text: "How can we improve computer science graduate student life at Harvard?"
    active: true # We are currently doing this one
  ]

  return unless ids
  [nycPrompt, csPrompt] = ids

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
  , # Harvard CS ideas
    text: "Provide more comfortable ergonomic office chairs for students"
    prompt: csPrompt
    type: "sim"
  ,
    text: "Install a large aquarium in Maxwell Dworkin with many tropical fish"
    prompt: csPrompt
    type: "sim"
  ,
    text: "Hold a hush-hush event where grad students can share stories about their advisors"
    prompt: csPrompt
    type: "diff"
  ,
    text: "Create a mentoring program matching graduate students with more senior students or faculty"
    prompt: csPrompt
    type: "diff"
  ]
