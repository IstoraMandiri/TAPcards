TAP.cols.Files = new CollectionFS 'files'

if Meteor.isClient
  Handlebars.registerHelper 'getImage', (fileId) ->
    TAP.cols.Files.findOne({_id:fileId})?.fileHandler.image500px.url
  
  Handlebars.registerHelper 'getProfileImage', (fileId) ->
    TAP.cols.Files.findOne({_id:fileId})?.fileHandler.image120px.url

  # also get audio
  # Handlebars.registerHelper 'getImage', (fileId) ->
  #   TAP.cols.Files.findOne({_id:fileId})?.fileHandler.image500px.url


if Meteor.isServer
  TAP.cols.Files.fileHandlers
    image500px: (options) ->
      destination = options.destination()
      if destination?
        Imagemagick.resize
          srcData: options.blob
          dstPath: destination.serverFilename
          width: 500
          height: 500
        return destination.fileData

    image120px: (options) ->
      destination = options.destination()
      if destination?
        Imagemagick.crop
          srcData: options.blob
          dstPath: destination.serverFilename
          width: 120
          height: 120
        return destination.fileData
