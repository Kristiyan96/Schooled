document.addEventListener("turbolinks:load", function() {
  id = $("#message_token").data('id');
  user_name = $("#message_token").data('name');
  token = $("#message_token").data('token');

  endpoint = "ws://localhost:4000/socket"
  socket = new Phoenix.Socket(endpoint, {params: {id: id, token: token, user_name: user_name}});
  socket.connect()

  let channel = socket.channel("user:" + id, {token: token, user_name: user_name, id: id})
  channel.on("init:usr", msg => console.log("Got message", msg) )

  channel.join()
    .receive("ok", ({messages}) => console.log("catching up", messages) )
    .receive("error", ({reason}) => console.log("failed join", reason) )
    .receive("timeout", () => console.log("Networking issue. Still waiting..."))
});
