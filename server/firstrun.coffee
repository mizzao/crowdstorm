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
    text: "Come up with an idea that <b>incorporates similar characteristics to these ideas</b>"
    inputs: [ "sim" ]
    active: true
  ,
    text: "Come up with an idea that <b>avoids characteristics of these ideas</b>"
    inputs: [ "diff" ]
    active: true
  ,
    text: "Come up with an idea that incorporates <b>similar characteristics to the ideas on the left</b> and <b>avoids characteristics of ideas on the right</b>"
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
    text: "organize regular informal research presentations/reading groups among small groups of students"
    prompt: csPrompt
    type: "sim"
  ,
    text: "Harvard CS idea 2"
    prompt: csPrompt
    type: "sim"
  ,
    text: "Harvard CS idea 3"
    prompt: csPrompt
    type: "diff"
  ,
    text: "Harvard CS idea 4"
    prompt: csPrompt
    type: "diff"
  ]
