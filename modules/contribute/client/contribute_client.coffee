Template.contribute.events = 
  'click .complete' : ->
    Router.go '/flashcards'

  'change input' : (e) ->
    files = e.target.files
    console.log TAP.cols.Files.storeFile(files[0])