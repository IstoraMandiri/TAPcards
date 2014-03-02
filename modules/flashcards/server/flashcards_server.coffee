
generateCardAnswers = (cardId, destLang, userId) ->
  card = TAP.cols.Cards.findOne({_id:cardId})
  if card
    card.options = [
      _id: card._id
      translation: card.translation[destLang].word
      correct:true
    ]
    query = {}
    query["translation.#{destLang}.verified"] = true
    console.log query
    cards = TAP.cols.Cards.find({_id:{$ne:card?._id},category:card?.category, query}).fetch()
    cards = _.sample cards, 3
    for wrongCard in cards
      card.options.push 
        _id: wrongCard._id
        translation: wrongCard.translation[destLang].word
    card.options = _.shuffle card.options
  return card

Meteor.methods

  'generateNextCards' : (destLang) ->
    randomCat = _.sample TAP.cols.Categories.find().fetch()
    query = {}
    query["translation.#{destLang}.verified"] = true
    randomCards = _.sample TAP.cols.Cards.find({category:randomCat._id,query}).fetch(), 2 # change to actual length
    randomCardIds = _.map randomCards, (card) -> card._id
    randomCardsWithAnswers = []
    for cardId in randomCardIds
      randomCardsWithAnswers.push generateCardAnswers(cardId,destLang,@userId)
    TAP.helpers.updateUserProfile @userId,
      $set:
        nextCards: randomCardsWithAnswers

  'answer': (options) ->
    console.log @userId, options
    # log the correct answers
