function joinRoom(id, channels, user, users, socket) {
  users.forEach(({sender_id, text, time, first_name, last_name}) => {
    chat_id = (sender_id < id) ? `${sender_id}:${id}` : `${id}:${sender_id}`

    channel = socket.channel(`chat:${chat_id}`, user)
    channels.push([channel, channel.topic])

    channel.on("init:msg", ({messages}) => {
      console.log(`Got unread messages with user ${sender_id}`, messages)
      messages.forEach(message => {
        appendMessage(channel.topic, id, message)
      })
    })

    channel.on("new:msg", m => {
      console.log(`Got new message with user ${sender_id}`, m)
      appendMessage(channel.topic, id, m)
    })
    channel.join()
      .receive("ok", ({payload}) => {
        sender = `${first_name} ${last_name}`
        prependUser(channel.topic, sender, text, time)
        console.log(`Joined with user: ${sender_id} successfully`, payload)
      })
      .receive("error", ({reason}) => console.log("failed join", reason) )
      .receive("timeout", () => console.log("Networking issue. Still waiting..."))
  })
}

//Add user at the end of the list with previous chats as inactive
function appendUser(topic, sender, time, last_message) {
  var recipient = $('#recipients .sample').clone().removeClass('sample')
                                .appendTo('#recipients').toggle('fast');
  recipient.children('a.nav-link').removeClass('active');

  recipient.find('.info .sender').text(sender);
  recipient.find('.info .time').text(time);
  recipient.find('.info .last-message').text(last_message);
}

//Add user at the beginning of the list with previous chats as active
function prependUser(topic, sender, time, last_message) {
  $('#recipients').find('a.nav-link.active').removeClass('active');
  var recipient = $('#recipients .sample')
    .clone()
    .removeClass('sample')
    .attr('data-topic', topic)

  if (!$(`li.nav-item[data-topic="${topic}"`).length){
    recipient.prependTo('#recipients').toggle('fast');

    recipient.on('click', function(e) {
      $('.message-container').addClass('hidden');
      $(`.message-container[data-topic="${topic}"]`).removeClass('hidden').removeClass('sample');
    })

    res = $('.message-container.sample')
      .clone()
      .removeClass('sample')
      .attr('data-topic', topic)
      .prependTo('#right-space')
  }

  recipient.find('a.nav-link').addClass('active');

  recipient.find('.info .sender').text(sender);
  recipient.find('.info .time').text(time);
  recipient.find('.info .last-message').text(last_message);
}

// Append a message send by me
function appendMyMessage(topic, sender, time, message){
  var message_box = $('.message-container .sample').find('.message-box.mine')
    .clone()
    .appendTo(`.message-container[data-topic="${topic}"]`);
  setMessageParams(message_box, sender, time, message);
}

// Append a message send by someone else
function appendElsesMessage(topic, sender, time, message){
  var message_box = $('.message-container .sample').find('.message-box.elses')
    .clone()
    .appendTo(`.message-container[data-topic="${topic}"]`);
  setMessageParams(message_box, sender, time, message);
}

function appendMessage(topic, id, {text, time, sender_id, first_name, middle_name, last_name}) {
  senderName = `${first_name} ${middle_name || ''} ${last_name}`
  if (id == sender_id) {
    appendMyMessage(topic, senderName, time, text)
  } else {
    appendElsesMessage(topic, senderName, time, text)
  }
}

function setMessageParams(message_box, sender, time, message){
  message_box.find('button.message').attr('title', time);
  message_box.find('.message-content .sender').html(sender);
  message_box.find('.message-content .msg').html(message);
}

document.addEventListener("turbolinks:load", function() {
  var channels = [];
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
    joinRoom(id, channels, user, rooms["User"], socket)
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

  prependUser("topic:topic", "Някой", "asdf", "12:30")

  // listen for message submit
  $('#new-message-box button').on('click tap', function(e){
    var message = $('#message-content').val();
    console.log(message)
    topic = $('#recipients .active').parent().data('topic');
    channel = channels.find((el) => el[1] == topic)[0]
    channel.push("new:msg", {'message': message})
  });
});
