console.log 'loaded'

@TAP = {}

languageISOs = ['zh','en']


TAP.cols =  
  Users: new Meteor.Collection 'users',
    schema: new SimpleSchema 
      'profile.name': 
        type: String
        defaultValue: 'Anon'
      language:
        type: String
        allowedValues: languageISOs
      correct: 
        type: Number
        defaultValue: 0
        min : 0
      wrong: 
        type: Number
        defaultValue : 0
        min : 0
      answered: 
        type: Number
        autoValue : ->
          @field('correct').value + @field('wrong').value
        min: 0

  Categories: new Meteor.Collection 'categories',
    schema: new SimpleSchema 
      translation: 
        type: Object
        blackbox:true

  Cards: new Meteor.Collection 'cards',
    schema: new SimpleSchema 
      image: 
        type: String
      audio:
        type: String
        optional:true
      category:
        type: String
      createdAt: 
        type: Date
        autoValue : ->
          if @isInsert
            new Date
          else if @isUpsert
            {$setOnInsert: new Date}
          else
            @unset()
        denyUpdate: true
      correct: 
        type: Number
        defaultValue: 0
        min : 0
      wrong: 
        type: Number
        defaultValue : 0
        min : 0
      answered: 
        type: Number
        autoValue : ->
          @field('correct').value + @field('wrong').value
        min: 0
      translation:
        type: Object
        blackbox: true

  Activity: new Meteor.Collection 'activity',
    schema: new SimpleSchema
      type:
        type: String
        allowedValues: ['verify','answer']
      user:
        type: Object
        blackbox: true
      cardId:
        type: String
      submission: # string
        type: String
      correct:
        type: Boolean
        optional: true
      timeTaken:
        type: Number
        optional: true
      createdAt:
        type: Date
        autoValue : ->
          if @isInsert
            new Date
          else if @isUpsert
            {$setOnInsert: new Date}
          else
            @unset()
        denyUpdate: true





#   Cards: new Meteor.Collection 'cards'


if Meteor.isClient
  TAP.subs = {}


if Meteor.isServer
  TAP.pubs = {}