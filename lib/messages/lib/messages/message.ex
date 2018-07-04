defmodule Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: Timex.Ecto.TimestampWithTimezone,
                    inserted_at: :created_at,
                    autogenerate: {Timex.Ecto.TimestampWithTimezone, :autogenerate, []}]

  schema "messages" do
    field :text, :string
    field :read, :boolean
    field :sender_type, :string
    field :sender_id, :integer
    field :recipient_type, :string
    field :recipient_id, :integer

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:text, :read, :sender_type, :sender_id, :recipient_type, :recipient_id])
    |> validate_required([:text, :sender_type, :sender_id, :recipient_type, :recipient_id])
  end
end

