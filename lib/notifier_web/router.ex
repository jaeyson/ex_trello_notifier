defmodule NotifierWeb.Router do
  use NotifierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NotifierWeb do
    pipe_through :api

    get "/", NotifierController, :index
    post "/sentry", NotifierController, :sentry
  end
end
