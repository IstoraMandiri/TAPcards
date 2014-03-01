Template.menu.userCreatedProfile = -> TAP.cols.UserProfiles.findOne()?.createdProfile

Template.selectLanguage.language_list = ->
	userLanguage = TAP.cols.UserProfiles.findOne()?.language
	_.map TAP.cols.Languages.find({_id: {$ne: userLanguage}}).fetch(), (language) ->
		obj = 
			_id: language._id
			string: language.translation[userLanguage]

Template.selectLanguage.events =
	"click .btn-success" : (event, template) ->
		Session.set 'targetLanguage', @_id