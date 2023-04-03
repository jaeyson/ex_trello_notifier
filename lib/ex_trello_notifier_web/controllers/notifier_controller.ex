defmodule ExTrelloNotifierWeb.NotifierController do
  use ExTrelloNotifierWeb, :controller

  alias ExTrelloNotifier.HttpClient
  alias ExTrelloNotifierWeb.FallbackController

  action_fallback FallbackController

  def index(conn, params) do
    render(conn, "index.json", params: params)
  end

  def notify(conn, params) do
    IO.inspect(params, label: "action params")
    title = get_in(params, ["data", "item", "title"])
    event = params["event_name"]
    level = get_in(params, ["data", "occurrence", "level"])
    total_occurrences = get_in(params, ["data", "item", "total_occurrences"])
    environment = get_in(params, ["data", "occurrence", "environment"])
    framework = get_in(params, ["data", "occurrence", "framework"])
    language = get_in(params, ["data", "occurrence", "language"])
    error_url = get_in(params, ["data", "url"])

    desc = """
    ### #{title}

    **Event**: `#{event}`

    **Level**: `#{level}`

    **Total occurrences**: `#{total_occurrences}`

    **Environment**: `#{environment}`

    **Framework**: `#{framework}`

    **Language**: `#{language}`

    [Error url: #{error_url}](#{error_url})
    """

    query = %{
      "name" => title,
      "desc" => desc,
      "urlSource" => error_url
    }

    with {:ok, _} <- HttpClient.create_new_card(query) do
      render(conn, "notify.json")
    else
      {:error, _reason} ->
        {:error, :not_found}
    end
  end
end
