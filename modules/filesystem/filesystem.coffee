TAP.cols.Files = new CollectionFS 'files'

if Meteor.isServer
  TAP.cols.Files.fileHandlers
    default: (options) -> { blob: options.blob, fileRecord: options.fileRecord }

