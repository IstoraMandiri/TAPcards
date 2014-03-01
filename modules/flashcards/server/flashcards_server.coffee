
generateCardAnswers = (cardId) ->
  # Session.get 'destinationLanguage', 'zh'
  destLang = 'zh' # change to user session
  card = TAP.cols.Cards.findOne({_id:cardId})
  if card
    cards = TAP.cols.Cards.find({_id:{$ne:card?._id},category:card?.category}, {limit:3}).fetch()
    card.options = [
      _id: card._id
      translation: card.translation[destLang].word
      correct:true
    ]
    for wrongCard in cards
      card.options.push 
        _id: wrongCard._id
        translation: wrongCard.translation[destLang].word
    card.options = _.shuffle card.options
  return card

Meteor.methods
  'generateNextCards' : ->
    randomCat = _.sample TAP.cols.Categories.find().fetch()
    randomCards = _.sample TAP.cols.Cards.find({category:randomCat._id}).fetch(), 10 # change to actual length
    randomCardIds = _.map randomCards, (card) -> card._id
    randomCardsWithAnswers = []
    for cardId in randomCardIds
      randomCardsWithAnswers.push generateCardAnswers(cardId)
    TAP.helpers.updateUserProfile @userId,
      $set:
        nextCards: randomCardsWithAnswers