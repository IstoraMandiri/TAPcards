@TAP = {}

languageISOs = ['aa','ab','ae','af','ak','am','an','ar','as','av','ay','az','ba','be','bg','bh','bi','bm','bn','bo','br','bs','ca','ce','ch','co','cr','cs','cu','cv','cy','da','de','dv','dz','ee','el','en','eo','es','et','eu','fa','ff','fi','fj','fo','fr','fy','ga','gd','gl','gn','gu','gv','ha','he','hi','ho','hr','ht','hu','hy','hz','ia','id','ie','ig','ii','ik','io','is','it','iu','ja','jv','ka','kg','ki','kj','kk','kl','km','kn','ko','kr','ks','ku','kv','kw','ky','la','lb','lg','li','ln','lo','lt','lu','lv','mg','mh','mi','mk','ml','mn','mr','ms','mt','my','na','nb','nd','ne','ng','nl','nn','no','nr','nv','ny','oc','oj','om','or','os','pa','pi','pl','ps','pt','qu','rm','rn','ro','ru','rw','sa','sc','sd','se','sg','si','sk','sl','sm','sn','so','sq','sr','ss','st','su','sv','sw','ta','te','tg','th','ti','tk','tl','tn','to','tr','ts','tt','tw','ty','ug','uk','ur','uz','ve','vi','vo','wa','wo','xh','yi','yo','za','zh','zu']

TAP.cols =  
  UserProfiles: new Meteor.Collection 'userProfiles'
  Languages: new Meteor.Collection 'languages'
  Categories: new Meteor.Collection 'categories'
  Cards: new Meteor.Collection 'cards'
  Activity: new Meteor.Collection 'activity'

if Meteor.isClient
  TAP.subs = 
    Files: Meteor.subscribe 'Files' 
    myProfile: Meteor.subscribe 'myProfile' 
    Categories: Meteor.subscribe 'Categories'
    Cards: Meteor.subscribe 'Cards'
    Activity: Meteor.subscribe 'Activity'
    Languages: Meteor.subscribe 'Languages'

if Meteor.isServer

  TAP.cols.UserProfiles.simpleSchema
      createdProfile: 
        type: Boolean
        optional:true
      name: 
        type: String
        defaultValue: 'Anon'
      language:
        type: String
        allowedValues: languageISOs
        optional:true
      image:
        type: String
        optional: true
      correct: 
        type: Number
        optional:true
        min : 0
        defaultValue:0
      wrong: 
        type: Number
        optional:true
        min : 0
        defaultValue:0
      answered: 
        type: Number
        autoValue : ->
          @field('correct').value + @field('wrong').value
        optional:true
      nextCards: 
        optional:true
        type: [Object]
        maxCount: 10
        minCount: 0
      'nextCards.$':
        blackbox:true
  
  TAP.cols.Languages.simpleSchema 
    translation: 
      type: Object
      blackbox:true
    _id:
      type: String
      allowedValues: languageISOs

  TAP.cols.Categories.simpleSchema 
    translation: 
      type: Object
      blackbox:true

  TAP.cols.Cards.simpleSchema 
    image: 
      type: String
      optional:true
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
    available:
      type: Boolean
      optional: true

  TAP.cols.Activity.simpleSchema
    type:
      type: String
      allowedValues: ['answer','verify','contribute']
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



  TAP.pubs =
    myProfile: Meteor.publish 'myProfile', -> 
      TAP.cols.UserProfiles.find 
        _id:Meteor.users.findOne({_id:@userId})?.profile._id
    Categories: Meteor.publish 'Categories', -> TAP.cols.Categories.find()
    Cards: Meteor.publish 'Cards', -> TAP.cols.Cards.find()
    Activity: Meteor.publish 'Activity', -> TAP.cols.Activity.find()
    Languages: Meteor.publish 'Languages', -> TAP.cols.Languages.find()

  Accounts.onCreateUser (options, user) ->
    # console.log options
    user.profile = 
      _id : TAP.cols.UserProfiles.insert({})
    return user

  Meteor.startup ->
    if TAP.cols.Languages.find().count() is 0
      console.log 'inserting languages'
      TAP.cols.Languages.insert
        _id: 'en'
        translation:
          'en':'English'
          'zh':'英語'
      
      TAP.cols.Languages.insert
        _id: 'zh'
        translation:
          'en':'Chinese'
          'zh':'中國'

    if TAP.cols.Categories.find().count() is 0
      console.log 'inserting cats + cards'
      catId1 = TAP.cols.Categories.insert
        translation:
          'en':'Food'
          'zh':'Food(translated)'
      catId2 = TAP.cols.Categories.insert
        translation:
          'en':'Cars'
          'zh':'Cars(translated)'

      for i in [0..30]
        TAP.cols.Cards.insert
          image: 'test.jpeg'
          category: catId1
          available:true
          translation:
            'en':
              word:"Food #{i}"
              verified: true
            'zh':
              word:"食物 #{i}"
              verified: true

      for i in [0..30]
        TAP.cols.Cards.insert
          image: 'test.jpeg'
          category: catId2
          available:true
          translation:
            'en':
              word: "Car #{i}"
              verified: true
            'zh':
              word: "汽車 #{i}"
              verified: true


