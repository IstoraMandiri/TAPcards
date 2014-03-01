
Meteor.methods 
  "submitAnswer": (options) ->
    console.log 'getting answer'
    console.log options

Meteor.startup ->
  if TAP.cols.Cards.count() is 0

    cards = [
        
    ]

    for card in cards
      TAP.cols.Cards.insert card  