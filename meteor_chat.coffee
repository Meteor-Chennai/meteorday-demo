@Rooms = new Mongo.Collection("rooms")
@Messages = new Mongo.Collection("messages")
if Meteor.isClient
  Template.hello.helpers
    rooms: ()->
      Rooms.find().fetch()

  Template.hello.events
    "click li": ->
      Session.set "activeRoom", @name

  Template.room.helpers
    activeRoom: ()->
      Session.get "activeRoom"
      
    messages: ()->
      Messages.find({room: Session.get("activeRoom")})	

  Template.room.events
    "keypress #message": (e)->
      message = $("#message").val().trim()
      if e.keyCode is 13 and message isnt ""
        Messages.insert
          room: Session.get "activeRoom"
          message: message
        $("#message").val("")
       	
