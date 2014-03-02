

# get a random category
# type the word
# get upload the image
# save it!

newCard = -> TAP.cols.Cards.findOne({_id:Session.get('contribCard')})

Template.contribute.events = 
  'click .save' : (event) ->
    $(event.target).removeClass('compelte').text('Thank You! Saving...')
    translation = {}
    translation[TAP.cols.UserProfiles.findOne()?.language] = 
      word:$('.name-it').val()
      verified:0 
    Meteor.setTimeout ->
      TAP.cols.Cards.update {_id:newCard()._id},
        $set:
          translation:translation
          available:true
          
      Router.go '/flashcards'
    , 3000

  'click .skip' : ->
    Router.go '/flashcards'

  'click .upload-image': ->
    $('.overlap-file').click()

  'change input[type="file"]' : (e) ->
    files = e.target.files
    newFile = TAP.cols.Files.storeFile(files[0])
    TAP.cols.Cards.update {_id:newCard()._id},
      $set:
        image:newFile
    Meteor.setTimeout ->
      $('.name-it').focus()
    , 2000


Template.contribute.newCard = -> newCard()

Template.contribute.category = -> TAP.cols.Categories.findOne({_id:newCard().category})?.translation[TAP.cols.UserProfiles.findOne()?.language]

# Template.image_upload.imageId = -> TAP.cols.Files.findOne({},{sort:{handledAt:-1}})?._id


