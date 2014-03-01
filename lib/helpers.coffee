TAP.helpers = 
  'getProfile': (userId) ->
    TAP.cols.UserProfiles.findOne
      _id: Meteor.users.findOne({_id: userId})?.profile?._id
  
  'getProfileId': (userId) ->
    TAP.helpers.getProfile(userId)?._id

  'updateUserProfile': (userId, update) ->
    TAP.cols.UserProfiles.update {_id:TAP.helpers.getProfileId(userId)}, update

  'randomCategory': -> _.sample(TAP.cols.Categories.find().fetch())?._id
