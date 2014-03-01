
Meteor.methods
  'generateNextCards' : ->
    randomCat = _.sample TAP.cols.Categories.find().fetch()
    randomCards = _.sample TAP.cols.Cards.find({category:randomCat._id}).fetch(), 10 # change to actual length
    randomCards = _.map randomCards, (card) -> card._id
    console.log 'updating'
    console.log 'uid', @userId
    console.log 'pid', TAP.helpers.getProfileId @userId
    TAP.helpers.updateUserProfile @userId,
      $set:
        nextCards: randomCards
    console.log 'updated', TAP.helpers.getProfile @userId
