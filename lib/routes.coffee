

if Meteor.isClient

  Router.configure
    layoutTemplate:'layout'

  Router.map ->
    @route 'home',
      path: '/'
      template: 'home'