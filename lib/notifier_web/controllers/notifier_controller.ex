defmodule NotifierWeb.NotifierController do
  use NotifierWeb, :controller

  alias NotifierWeb.FallbackController
  alias Notifier.HttpClient

  action_fallback FallbackController

  def sentry_project_host, do: Application.get_env(:notifier, :sentry_project_host)
  def sentry_issue_path, do: Application.get_env(:notifier, :sentry_issue_path)

  def index(conn, params) do
    IO.inspect(params, label: "index")
    render(conn, "index.json", params: params)
  end

  def sentry(conn, params) do
    issue = get_in(params, ["data", "issue"])
    path = Path.join(["/", sentry_issue_path(), issue["id"]])

    issue_url =
      %URI{
        scheme: HttpClient.scheme(),
        host: sentry_project_host(),
        path: path
      }
      |> URI.to_string()

    desc = """
    ### #{issue["title"]}

    **culprit**: `#{issue["culprit"]}`

    **type**: `#{issue["metadata"]["type"]}`

    **status**: `#{issue["status"]}`

    **level**: `#{issue["level"]}`

    **platform**: `#{issue["platform"]}`

    [issue_url](#{issue_url})
    """

    query = %{
      "name" => issue["title"],
      "desc" => desc,
      # "urlSource" => issue_url
    }

    {:ok, _} = HttpClient.create_new_card(query)

    # render(conn, "sentry.json", params: params)
    render(conn, "sentry.json")
  end
end
