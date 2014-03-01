Template.flashCard.card = -> TAP.helpers.getProfile(Meteor.userId())?.nextCards[0]

Template.flashCard.events = 
  'click .choice' : (event) ->
    $card = $(event.target).parentsUntil('.card')
    console.log $card.html()
    if @correct
      $card.addClass 'answered correctly' 
    else
      $card.addClass 'answered incorrectly'