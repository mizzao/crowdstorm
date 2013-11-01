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
    text: "Provide more commuter rail access to Manhattan"

  Items.insert
    text: "Facilitate greater access to rooftops for tenants' container gardening"
