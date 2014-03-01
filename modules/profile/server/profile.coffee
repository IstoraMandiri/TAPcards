Meteor.publish 'userData', ->
	return Meteor.users.find {_id: this.userId}, {fields: {'emails' : 1}}

Meteor.users.allow
	update: (userId, user, fields, modifier) ->
		if user._id is userId
			Meteor.users.update({_id: userId}, modifier)
			return true
		else
			return false