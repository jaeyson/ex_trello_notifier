defmodule ExTrelloNotifierWeb.FallbackController do
  use ExTrelloNotifierWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ExTrelloNotifierWeb.ErrorView)
    |> render("404.json")
  end
end
