defmodule MessagesWeb.UserChannel do
  use Phoenix.Channel

  def join("user:" <> user_id, _info, socket) do
    if socket.assigns.user_id == user_id do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    #TODO: select messages from groups/etc
    conversations = Messages.unread(socket.assigns.user_id)
    push socket, "init:usr", conversations
    {:noreply, socket}
  end

  # def handle_in("new:msg", socket) do
  #   #TODO handle notification for new message
  # end
end
