defmodule Messages.User do
  use Ecto.Schema

  @timestamps_opts [type: Timex.Ecto.TimestampWithTimezone,
                    inserted_at: :created_at,
                    autogenerate: {Timex.Ecto.TimestampWithTimezone, :autogenerate, []}]

  schema "users" do
    field :first_name, :string
    field :middle_name, :string
    field :last_name, :string

    field :group_id, :integer

    timestamps()
  end
end
