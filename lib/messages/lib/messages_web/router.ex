defmodule MessagesWeb.Router do
  use MessagesWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MessagesWeb do
    pipe_through :api
  end
end
