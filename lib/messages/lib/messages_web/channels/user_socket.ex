defmodule MessagesWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "user:*", MessagesWeb.UserChannel
  channel "chat:*", MessagesWeb.ChatChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.

  def connect(%{"token" => token, "id" => user_id, "user_name" => user_name}, socket) do
    if Messages.Helper.ensure_hash(token, "#{user_id}:#{user_name}") do
      {:ok, socket |> assign(:user_id, user_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     MessagesWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
