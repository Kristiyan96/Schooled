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
});
