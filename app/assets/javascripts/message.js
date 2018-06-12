function joinRoom(id, user, users, socket) {
  users.forEach(u => {
    chat_id = (u < id) ? `${u}:${id}` : `${id}:${u}`

    channel = socket.channel(`chat:${chat_id}`, user)
    channel.on("init:msg", messages =>
      console.log(`Got messages with user ${u}`, messages)
    )
    channel.join()
      .receive("ok", ({messages}) =>
        console.log(`Joined with user: ${u} successfully`, messages)
      )
      .receive("error", ({reason}) => console.log("failed join", reason) )
      .receive("timeout", () => console.log("Networking issue. Still waiting..."))
  })
}

//Add user at the end of the list with previous chats as inactive
function appendUser(sender, time, last_message) {
  var recipient = $('#recipients .sample').clone().removeClass('sample')
                                .appendTo('#recipients').toggle('fast');
  recipient.children('a.nav-link').removeClass('active');

  recipient.find('.info .sender').text(sender);
  recipient.find('.info .time').text(time);
  recipient.find('.info .last-message').text(last_message);
}

//Add user at the beginning of the list with previous chats as active
function prependUser(sender, time, last_message) {
  $('#recipients').find('a.nav-link.active').removeClass('active');
  var recipient = $('#recipients .sample').clone().removeClass('sample')
                                .prependTo('#recipients').toggle('fast');
  recipient.find('a.nav-link').addClass('active');

  recipient.find('.info .sender').text(sender);
  recipient.find('.info .time').text(time);
  recipient.find('.info .last-message').text(last_message);
}

// Append a message send by me
function appendMyMessage(sender, time, message){
  var message_box = $('#message-box').find('.message-box.mine.hidden')
                                        .clone().removeClass('hidden')
                                        .appendTo('#message-box');
  setMessageParams(message_box, sender, time, message);
}

// Append a message send by someone else
function appendElsesMessage(sender, time, message){
  var message_box = $('#message-box').find('.message-box.elses.hidden')
                                        .clone().removeClass('hidden')
                                        .appendTo('#message-box');
  setMessageParams(message_box, sender, time, message);
}

function setMessageParams(message_box, sender, time, message){
  message_box.find('button.message').attr('title', time);
  message_box.find('.message-content .sender').html(sender);
  message_box.find('.message-content .msg').html(message);
}

document.addEventListener("turbolinks:load", function() {
  id = $("#message_token").data('id');
  user_name = $("#message_token").data('name');
  token = $("#message_token").data('token');
  user = {id: id, token: token, user_name: user_name}

  endpoint = "ws://localhost:4000/socket" // TODO: fix for production
  socket = new Phoenix.Socket(endpoint, {params: user});
  socket.connect()

  let channel = socket.channel("user:" + id, user)
  channel.on("init:usr", (rooms) => {
    console.log("Got rooms", rooms)
    joinRoom(id, user, rooms["User"], socket)
    // joinGroup
    // joinTeachers
    // joinParents
    // joinStudents
  })

  channel.join()
    .receive("ok", ({messages}) =>
      console.log("catching up", messages)
    )
    .receive("error", ({reason}) => console.log("failed join", reason) )
    .receive("timeout", () => console.log("Networking issue. Still waiting..."))


  // listen for message submit
  $('body').on('click tap', '#new-message-box button', function(e){
    var message = $('#new-message-box textarea').val();
    alert(message);
  });
});
