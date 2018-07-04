defmodule Messages do
  alias Messages.{Repo, Message, User}
  import Ecto.Query, only: [from: 2]

  @moduledoc """
  Messages keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Get messages between two users.

  ## Examples

      Messages.between(["1", "2"])
  """
  def between(users) do
    from(
      m in Message,
      join: u in User,
      on: u.id == m.sender_id,
      where:
        m.sender_type == "User" and m.recipient_type == "User" and m.sender_id in ^users and
          m.recipient_id in ^users,
      select: %{
        text: m.text,
        time: m.created_at,
        sender_id: m.sender_id,
        first_name: u.first_name,
        middle_name: u.middle_name,
        last_name: u.last_name
      },
      order_by: m.id
    )
    |> Repo.all()
  end

  @doc """
  Get unread messages for a user.
  """
  def unread(user_id) do
    from(
      m in Message,
      join: u in User, on: u.id == m.sender_id,
      where: m.recipient_id == ^user_id and m.recipient_type == "User" and m.read == false,
      select: %{
        sender_id: m.sender_id,
        type: m.sender_type,
        text: m.text,
        time: m.created_at,
        first_name: u.first_name,
        last_name: u.last_name,
      },
      distinct: true
    )
    |> Repo.all()
    |> Enum.group_by(
      fn %{type: type} -> type end,
      fn x -> Map.delete(x, :type) end
    )
  end

  @doc """
  Read messages for a user sent by a user or group.
  Defaults to a user.
  """
  def read(id, recipient, sender, sender_type \\ "User") do
    from(
      m in Message,
      where:
        m.recipient_id == ^recipient and m.sender_id == ^sender and m.sender_type == ^sender_type and
          m.recipient_type == "User" and m.id <= ^id
    )
    |> Repo.update_all(set: [read: true])
  end

  @doc """
  Create message with contents from a user to a user.
  """
  def create(sender_id, recipient_id, message) do
    changes = %{
      sender_id: sender_id,
      sender_type: "User",
      recipient_id: recipient_id,
      recipient_type: "User",
      text: message
    }

    Message.changeset(%Message{}, changes)
    |> Repo.insert()
  end

  def create_group(sender_id, group_id, message) do
    changes = %{
      sender_id: sender_id,
      sender_type: "User",
      recipient_id: group_id,
      recipient_type: "Group",
      text: message
    }

    Message.changeset(%Message{}, changes)
    |> Repo.insert()
  end

  def groups(user_id) do
    from(u in User, where: u.id == ^user_id, select: u.group_id)
    |> Repo.all()
  end

  def for_group(group, user) do
    from(
      m in Message,
      where:
        m.sender_id == ^group and m.sender_type == "Group" and m.recipient_id == ^user and
          m.recipient_type == "User" and m.read == false,
      select: [m.text, m.sender_id, m.sender_type, m.recipient_id, m.recipient_type]
    )
    |> Repo.all()
  end

  def in_group(group) do
    from(
      u in User,
      where: u.group_id == ^group,
      select: [u.id]
    )
  end
end
