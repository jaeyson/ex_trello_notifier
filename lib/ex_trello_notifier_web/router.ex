defmodule ExTrelloNotifierWeb.Router do
  use ExTrelloNotifierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExTrelloNotifierWeb do
    pipe_through :api

    get "/", NotifierController, :index
    post "/notify", NotifierController, :notify
  end
end
