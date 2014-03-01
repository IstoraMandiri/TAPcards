

if Meteor.isClient
  Template.home.greeting = -> 'You are running meteor'

  Handlebars.registerHelper 'userProfile', -> TAP.cols.UserProfiles.findOne()

