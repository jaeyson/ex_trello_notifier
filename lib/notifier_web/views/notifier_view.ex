defmodule NotifierWeb.NotifierView do
  use NotifierWeb, :view
  
  def render("index.json", _params) do
    %{message: "ok"}
  end

  # def render("sentry.json", %{params: _params}) do
  def render("sentry.json", _) do
    %{message: "sent to Trello"}
  end
end