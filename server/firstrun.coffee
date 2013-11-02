# Put our 5 questions into the Tasks collection
Meteor.startup ->
  return if Tasks.find().count() > 0

  Tasks.insert
    text: "Come up with something similar to this idea"
    inputs: 1

  Tasks.insert
    text: "Come up with something different from this idea"
    inputs: 1

  Tasks.insert
    text: "Come up with something similar to both these ideas"
    inputs: 2

  Tasks.insert
    text: "Come up with something different from both these ideas"
    inputs: 2

  Tasks.insert
    text: "Come up with something similar to the idea on the left and different from the one on the right"
    inputs: 2

# Load the prompts
Meteor.startup ->
  return if Prompts.find().count() > 0

  Prompts.insert
    text: "How do we create a greener and greater New York City?"

# Load a couple of ideas
Meteor.startup ->
  return if Items.find().count() > 0

  Items.insert
    text: "Allow access to drinking water sampling stations to let people refill reusable bottles."
    type: "transportation"

  Items.insert
    text: "Promote cycling by installing safe bike lanes"
    type: "transportation"

  Items.insert
    text: "Improve schools in all districts so kids don't travel so far"
    type: "education"

  Items.insert
    text: "Promote the use of solar energy using the latest technology on all high-rise buildings"
    type: "energy"

  Items.insert
    text: "Replace sodium vapor street lights with LED or other energy-saving lights"
    type: "technology"

  Items.insert
    text: "Preserve natural areas and woodlands as natural parks"
    type: "environment"