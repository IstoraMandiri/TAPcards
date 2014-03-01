console.log 'loaded'

@TAP = {}

languageISOs = ['ABW','AFG','AGO','AIA','ALA','ALB','AND','ARE','ARG','ARM','ASM','ATA','ATF','ATG','AUS','AUT','AZE','BDI','BEL','BEN','BES','BFA','BGD','BGR','BHR','BHS','BIH','BLM','BLR','BLZ','BMU','BOL','BRA','BRB','BRN','BTN','BVT','BWA','CAF','CAN','CCK','CHE','CHL','CHN','CIV','CMR','COD','COG','COK','COL','COM','CPV','CRI','CUB','CUW','CXR','CYM','CYP','CZE','DEU','DJI','DMA','DNK','DOM','DZA','ECU','EGY','ERI','ESH','ESP','EST','ETH','FIN','FJI','FLK','FRA','FRO','FSM','GAB','GBR','GEO','GGY','GHA','GIB','GIN','GLP','GMB','GNB','GNQ','GRC','GRD','GRL','GTM','GUF','GUM','GUY','HKG','HMD','HND','HRV','HTI','HUN','IDN','IMN','IND','IOT','IRL','IRN','IRQ','ISL','ISR','ITA','JAM','JEY','JOR','JPN','KAZ','KEN','KGZ','KHM','KIR','KNA','KOR','KWT','LAO','LBN','LBR','LBY','LCA','LIE','LKA','LSO','LTU','LUX','LVA','MAC','MAF','MAR','MCO','MDA','MDG','MDV','MEX','MHL','MKD','MLI','MLT','MMR','MNE','MNG','MNP','MOZ','MRT','MSR','MTQ','MUS','MWI','MYS','MYT','NAM','NCL','NER','NFK','NGA','NIC','NIU','NLD','NOR','NPL','NRU','NZL','OMN','PAK','PAN','PCN','PER','PHL','PLW','PNG','POL','PRI','PRK','PRT','PRY','PSE','PYF','QAT','REU','ROU','RUS','RWA','SAU','SDN','SEN','SGP','SGS','SHN','SJM','SLB','SLE','SLV','SMR','SOM','SPM','SRB','SSD','STP','SUR','SVK','SVN','SWE','SWZ','SXM','SYC','SYR','TCA','TCD','TGO','THA','TJK','TKL','TKM','TLS','TON','TTO','TUN','TUR','TUV','TWN','TZA','UGA','UKR','UMI','URY','USA','UZB','VAT','VCT','VEN','VGB','VIR','VNM','VUT','WLF','WSM','YEM','ZAF','ZMB','ZWE']

TAP.cols =  
  userProfileSchema: new SimpleSchema
      userId: 
        type: String
      name: 
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



if Meteor.isClient
  TAP.subs = {}


if Meteor.isServer
  TAP.pubs = {}

  # Accounts.onCreateUser (options, user) ->
  #   TAP.cols.userProfileSchema.clean user.profile
  #   console.log options, user
  #   return user




