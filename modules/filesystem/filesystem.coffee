TAP.cols.Files = new CollectionFS 'files'

if Meteor.isClient
  Handlebars.registerHelper 'getImage', (fileId) ->
    TAP.cols.Files.findOne({_id:fileId})?.fileHandler.default.url

if Meteor.isServer
  TAP.cols.Files.fileHandlers
    default: (options) -> { blob: options.blob, fileRecord: options.fileRecord }
