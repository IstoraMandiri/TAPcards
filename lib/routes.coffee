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
                if Session.get('targetLanguage')
                    Meteor.call 'generateNextCards', Session.get('targetLanguage')


    @.route 'verify',
        path: '/verify'
        template: 'verify'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'
            else
                user = TAP.helpers.getProfile(Meteor.userId())
                if user?
                    query = {}
                    query["translation.#{user.language}.verified"] = {'$ne':true}
                    query["available"] = true
                    verifyCard = _.sample(TAP.cols.Cards.find(query).fetch())?._id
                    if verifyCard
                        Session.set 'verifyCardId', verifyCard
                    else
                        @.redirect '/contribute'




    @.route 'contribute',
        path: '/contribute'
        template: 'contribute'
        layoutTemplate: 'layout'
        before: ->
            if not Meteor.loggingIn() and not Meteor.user()
                @.redirect '/login'
            else
                # random category
                Session.set 'contribCard', TAP.cols.Cards.insert
                    category:TAP.helpers.randomCategory()
                    available:false
