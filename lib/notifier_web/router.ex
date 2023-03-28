defmodule NotifierWeb.Router do
  use NotifierWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NotifierWeb do
    pipe_through :api
  end
end
