

Template.contribute.events = 
  'click .complete' : ->
    Router.go '/flashcards'

  'change input' : (e) ->
    # create a new card
    files = e.target.files
    console.log TAP.cols.Files.storeFile(files[0])
    cardId = TAP.cols.Cards.insert


Template.contribute.helpers =
    newCard: -> {}      


