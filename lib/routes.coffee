if Meteor.isClient

  Router.map ->
    @.route 'menu',
        path: '/'
        template: 'menu'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'

    @.route 'selectLanguage',
        path: '/selectLanguage'
        template: 'selectLanguage'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'

    @.route 'login',
        path: '/login'
        template: 'login'
        layoutTemplate: 'layout'
        before: ->
            if Meteor.user()
                @.redirect '/'


    @.route 'profile',
        path: '/profile'
        template: 'profile'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'

    @.route 'flashcards',
        path: '/flashcards'
        template: 'flashcards'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'
            else
              Meteor.startup ->
                Meteor.call 'generateNextCards', Session.get('targetLanguage')
