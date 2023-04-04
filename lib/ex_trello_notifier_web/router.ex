defmodule ExTrelloNotifierWeb.Router do
  use ExTrelloNotifierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExTrelloNotifierWeb do
    pipe_through :api

    get "/notify", NotifierController, :notify
  end
end
