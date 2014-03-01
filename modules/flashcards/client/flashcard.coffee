if Meteor.isClient
  # Meteor.subscribe "Card", ->Session.set "Card", true
  # console.log Session.get("Card")
  # card = new Meteor.Collection "Card"
  # Template.flashCard = 
  myLang = 'ABW'
  destLang = 'AFG'


  Template.flashCard.card = 
    image: "test.jpeg"
    options: [1,2,3]
  # Template.flashCard.card = -> 
  #   card = TAP.cols.Cards.findOne({})
  #   if card
  #     cards = TAP.cols.Cards.find({_id:{$ne:card?._id},category:card?.category}, {limit:2}).fetch()
  #     card.options = [
  #       _id: card._id
  #       translation: card.translation[destLang].word
  #       correct:true
  #     ]
  #     for wrongCard in cards
  #       card.options.push 
  #         _id: wrongCard._id
  #         translation: wrongCard.translation[destLang].word
  #     card.options = _.shuffle card.options
  #   card

  # Template.flashCard.events = 
  #   "click .choice": (evt) ->
  #     Meteor.call 'submitAnswer', 
  #       cardId: Session.get 'cardId'
  #       answer: @_id
  #     , ->
  #     if @correct 
  #       # alert "You pick the right choice"
  #       $(evt.target).css "background", "green"
  #     else
  #       $(evt.target).css "background", "red"