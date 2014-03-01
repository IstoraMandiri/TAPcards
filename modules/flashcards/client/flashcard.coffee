if Meteor.isClient
  # Meteor.subscribe "Card", ->Session.set "Card", true
  # console.log Session.get("Card")
  # card = new Meteor.Collection "Card"
  # Template.flashCard = 
  Template.flashCard.card = 
    image: "test.jpeg"
    topWord: 'Apple (in chinese)' 
    choices: [
      _id: 'asdkads'
      string: 'Apple'
      correct: true
    ,
      _id: 'asd129ud'
      string: 'Banana'
      # correct: false
    ,
      _id: '21912'
      string: 'Cabbage'
      # correct: false
    ]

  Template.flashCard.events = 
    "click .choice": (evt) ->
      Meteor.call 'submitAnswer', 
        cardId: Session.get 'cardId'
        answer: @_id
      , ->
        console.log 'got'
      if @correct 
        # alert "You pick the right choice"
        $(evt.target).css "background", "green"
      else
        $(evt.target).css "background", "red"