
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
    console.log 'options', @userId, options
    card = TAP.cols.Cards.findOne({_id:options.answeredCard})
    profile_id = TAP.helpers.getProfileId @userId
    # update user correct/wrong
    console.log 'updating profile', profile_id
    if options.correct
      TAP.helpers.updateUserProfile @userId, 
        $inc: 
          correct: 1
    else 
      TAP.helpers.updateUserProfile @userId, 
        $inc: 
          wrong: 1

    #update question correct/wrong
    if options.correct
      TAP.cols.Cards.update {_id: options.currentCard},
        $inc:
          correct: 1
    else
      TAP.cols.Cards.update {_id: options.currentCard},
        $inc:
          wrong: 1

    # log the correct answers
    profile = TAP.helpers.getProfile @userId

    user =
      _id: @userId
      profile:
        _id:profile._id
        answered: profile.answered
        correct: profile.correct
        wrong: profile.wrong 

    # insert one activity
    TAP.cols.Activity.insert
      type: "answer"
      user: @userId
      cardId: options.currentCard
      submission: options.answeredCard
      correct: options.correct
