

if Meteor.isClient
  Handlebars.registerHelper 'userProfile', -> TAP.cols.UserProfiles.findOne()
  Handlebars.registerHelper 'myLanguage', -> TAP.cols.UserProfiles.findOne()?.language
