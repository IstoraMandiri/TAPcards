Template.login.logToConsole = -> console.log 'login template'

Template.card_count.cardCount = -> 10 - TAP.cols.UserProfiles.findOne()?.nextCards.length
Template.navbar.learning = -> Session.get 'learning'