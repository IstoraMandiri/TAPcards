if Meteor.isClient

  Router.configure
    layoutTemplate:'layout'

  Router.map ->
    @.route 'home',
    	path: '/'
    	template: 'menu'
    	before: ->
    		if not Meteor.loggingIn() and not Meteor.user()
    			@.render 'login'

    @.route 'login',
    	path: '/login'
    	template: 'login'

    @.route 'profile',
    	path: '/profile'
    	template: 'profile'
    	before: ->
    		if not Meteor.loggingIn() and not Meteor.user()
    			@.render 'login'

    @.route 'flashcards',
    	path: '/flashcards'
    	template: 'flashcards'