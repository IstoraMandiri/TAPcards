

if Meteor.isClient
  
  Meteor.startup ->
    Meteor.call 'generateNextCards'


  Handlebars.registerHelper 'userProfile', -> TAP.cols.UserProfiles.findOne()

