
generateCardAnswers = (cardId, destLang) ->
  card = TAP.cols.Cards.findOne({_id:cardId})
  if card
    card.options = [
      _id: card._id
      translation: card.translation[destLang].word
      correct:true
    ]
    cards = TAP.cols.Cards.find({_id:{$ne:card?._id},category:card?.category}).fetch()
    cards = _.sample cards, 3
    for wrongCard in cards
      card.options.push 
        _id: wrongCard._id
        translation: wrongCard.translation[destLang].word
    card.options = _.shuffle card.options
  return card

Meteor.methods
  'generateNextCards' : (destLang) ->
    console.log 'destlang is', destLang
    randomCat = _.sample TAP.cols.Categories.find().fetch()
    randomCards = _.sample TAP.cols.Cards.find({category:randomCat._id}).fetch(), 10 # change to actual length
    randomCardIds = _.map randomCards, (card) -> card._id
    randomCardsWithAnswers = []
    for cardId in randomCardIds
      randomCardsWithAnswers.push generateCardAnswers(cardId,destLang)
    TAP.helpers.updateUserProfile @userId,
      $set:
        nextCards: randomCardsWithAnswers

  'answer': (options) ->
    console.log @userId, options
    
    # insert one activity
    TAP.cols.Activity.insert
      type: "answer"
      user: @userId
      cardId: options.currentCard

    # update user correct/wrong
    if options.correct
      TAP.cols.UserProfiles.update _id: @userId, 
        $inc: 
          correct: 1
    else TAP.cols.UserProfiles.update _id: @userId, 
        $inc: 
          wrong: 1

    #update question correct/wrong
    if options.correct
      TAP.cols.Cards.update _id: options: answeredCard,
        $inc:
          correct: 1
    else
      TAP.cols.Cards.update _id: options: answeredCard,
        $inc:
          wrong: 1

    # log the correct answers
