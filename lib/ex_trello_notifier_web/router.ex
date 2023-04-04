defmodule ExTrelloNotifierWeb.Router do
  use ExTrelloNotifierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExTrelloNotifierWeb do
    pipe_through :api
  end
end
