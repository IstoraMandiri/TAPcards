Template.verify.events = 
  'click .complete' : ->
    Router.go '/contribute'

thisCard = -> TAP.cols.Cards.findOne({_id: Session.get('verifyCardId')}) 

Template.verify.card = -> 
  console.log thisCard()
  thisCard()

myLanguage = ->
  TAP.helpers.getProfile(Meteor.userId())?.language

Template.verify.thisWord = -> thisCard().translation[myLanguage()]?.word
