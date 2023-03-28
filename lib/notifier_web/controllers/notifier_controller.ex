defmodule NotifierWeb.NotifierController do
  use NotifierWeb, :controller

  alias NotifierWeb.FallbackController
  alias Notifier.HttpClient

  action_fallback FallbackController

  def index(conn, _params) do
    render(conn, "index.json")
  end

  def sentry(conn, params) do
    issue = get_in(params, ["data", "issue"])
    title = issue["title"]
    status = issue["status"]
    level = issue["level"]
    last_seen = issue["lastSeen"]
    first_seen = issue["firstSeen"]
    permalink = issue["permalink"]
    # event_count = issue["count"]

    desc = """
    #{title}
    status: #{status}
    level: #{level}
    permalink: #{permalink}
    first seen: #{first_seen}
    last seen: #{last_seen}
    """

    query = %{
      "name" => title,
      "desc" => desc,
      "urlSource" => permalink
    }

    :ok = HttpClient.create_new_card(query)

    # render(conn, "sentry.json", params: params)
    render(conn, "sentry.json")
  end
  
end