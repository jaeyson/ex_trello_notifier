defmodule ExTrelloNotifierWeb.NotifierController do
  use ExTrelloNotifierWeb, :controller

  def notify(conn, _params) do
    render(conn, "notify.json")
  end
end
