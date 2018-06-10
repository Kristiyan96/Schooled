defmodule MessagesWeb.UserChannel do
  use Phoenix.Channel
  alias Messages.{Repo, Message}
  import Ecto.Query, only: [from: 2]

  def join("user:" <> user_id, _info, socket) do
    Process.flag(:trap_exit, true)
    if socket.assigns.user_id == user_id do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    #TODO: select messages from groups/etc
    users = from(m in Message,
      where: (m.recepient_id == ^socket.assigns.user_id and m.recepient_type == "User"),
      select: m.sender_id,
      distinct: true)
      |> Repo.all
    push socket, "init:usr", %{users: users}
    {:noreply, socket}
  end
end
