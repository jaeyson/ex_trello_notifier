defmodule NotifierWeb.NotifierController do
  use NotifierWeb, :controller

  alias Notifier.HttpClient
  alias NotifierWeb.FallbackController

  action_fallback FallbackController

  def sentry_project_host, do: Application.get_env(:sentry_notifier, :sentry_project_host)
  def sentry_issue_path, do: Application.get_env(:sentry_notifier, :sentry_issue_path)

  def index(conn, params) do
    render(conn, "index.json", params: params)
  end

  def sentry(conn, params) do
    IO.inspect(params, label: "sentry action params")
    culprit = params["culprit"]
    issue_url = params["url"]
    project_name = params["project_name"]
    message = params["message"]
    level = params["level"]

    desc = """
    ### #{message}

    **Culprit**: `#{culprit}`

    **Project**: `#{project_name}`

    **Level**: `#{level}`

    [Issue_url: #{issue_url}](#{issue_url})
    """

    query = %{
      "name" => message,
      "desc" => desc,
      # "urlSource" => issue_url
    }

    {:ok, _} = HttpClient.create_new_card(query)

    # render(conn, "sentry.json", params: params)
    render(conn, "sentry.json")
  end
end
