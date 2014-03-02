thisCard = ->
  TAP.helpers.getProfile(Meteor.userId())?.nextCards[0]

Template.flashCard.card = -> 
  currentCard = thisCard()
  Session.set 'currentCard', currentCard?._id
  return currentCard

Template.flashCard.cardTranslations = ->
  obj = 
    mine: thisCard()?.translation[TAP.helpers.getProfile(Meteor.userId()).language].word
    destination: thisCard()?.translation[Session.get('targetLanguage')]?.word

Template.flashCard.answered = ->  thisCard()?.correctAnswer?

Template.flashCard.lastAnswer = -> Session.get 'lastAnswer'

Template.flashCard.events = 
  'click .choice' : (event) ->
    $card = $(event.target).parents('.card')
    Session.set 'lastAnswer', @
    Meteor.call 'answer',
      answeredCard : @_id
      currentCard : Session.get 'currentCard'

    nextCards = TAP.helpers.getProfile(Meteor.userId())?.nextCards
    nextCards[0].correctAnswer = @correct or false
    
    TAP.helpers.updateUserProfile Meteor.userId(),
      $set: 
        'nextCards':nextCards

  'click .complete' : ->

    TAP.helpers.updateUserProfile Meteor.userId(),
      $pull: 
        nextCards: {_id:Session.get('currentCard')}

    if TAP.helpers.getProfile(Meteor.userId())?.nextCards.length is 0
      Router.go '/verify'

    if TAP.cols.UserProfiles.findOne()?.nextCards.length is 0
      Session.set 'learning', false