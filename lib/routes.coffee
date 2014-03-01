if Meteor.isClient

  Router.map ->
    @.route 'menu',
    	path: '/'
    	template: 'menu'
    	layoutTemplate: 'layout'
    	before: ->
    		if not Meteor.user()
    			@.redirect '/login'

    @.route 'selectLanguage',
    	path: '/selectLanguage'
    	template: 'selectLanguage'
    	layoutTemplate: 'layout'

    @.route 'login',
    	path: '/login'
    	template: 'login'
    	layoutTemplate: 'layout'

    @.route 'profile',
    	path: '/profile'
    	template: 'profile'
    	layoutTemplate: 'layout'
    	before: ->
    		if not Meteor.loggingIn() and not Meteor.user()
    			@.render 'login'

    @.route 'flashcards',
    	path: '/flashcards'
    	template: 'flashcards'
    	layoutTemplate: 'layout'
    	before: ->
    		if not Meteor.loggingIn() and not Meteor.user()
    			@.render 'login'
    	yieldTemplates:
    		'footer': {to: 'footer'}