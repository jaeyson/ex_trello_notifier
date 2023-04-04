defmodule ExTrelloNotifier.HttpClient do
  @moduledoc false

  @label_colors [
    :red,
    :green,
    :yellow,
    :orange,
    :purple,
    :blue
  ]

  @status_names [
    "Recurring",
    "Resolved",
    "Wont Fix",
    "Unresolved"
  ]

  def trello_api_key, do: Application.get_env(:ex_trello_notifier, :trello_api_key)
  def trello_api_token, do: Application.get_env(:ex_trello_notifier, :trello_api_token)
  def trello_base_url, do: Application.get_env(:ex_trello_notifier, :trello_base_url)
  def trello_board_id, do: Application.get_env(:ex_trello_notifier, :trello_board_id)
  def trello_api_version, do: Application.get_env(:ex_trello_notifier, :trello_api_version)
  def scheme, do: Application.get_env(:ex_trello_notifier, :scheme)

  @doc false
  def request(method, path, query) do
    path = Path.join(["/", trello_api_version(), path])
    credentials = %{"key" => trello_api_key(), "token" => trello_api_token()}
    query = Map.merge(query, credentials)

    url = %URI{
      scheme: scheme(),
      host: trello_base_url(),
      port: 443,
      path: path,
      query: URI.encode_query(query)
    }

    options = [timeout: 5_000, recv_timeout: 5_000]

    headers = [{"Content-Type", "application/json"}]

    request = HTTPoison.request(method, url, "", headers, options)

    case request do
      {:ok, response} ->
        {:ok, Jason.decode!(response.body)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_list_id(list_name) do
    method = :get
    path = "boards/#{trello_board_id()}/lists"
    query = %{}
    {:ok, lists} = request(method, path, query)

    lists
    |> Enum.filter(&(String.downcase(&1["name"]) === list_name))
    |> hd()
    |> Map.get("id")
  end

  def create_new_card(%{"name" => _, "desc" => _} = query) do
    list_name = "todo"
    method = :post
    path = "cards"
    label_id = get_label_id("Unresolved")

    query =
      query
      |> Map.put("idList", get_list_id(list_name))
      |> Map.put("idLabels", label_id)

    request(method, path, query)
  end

  def get_label_id(status_name) when status_name in @status_names do
    method = :get
    path = "boards/#{trello_board_id()}/labels"
    query = %{}

    {:ok, labels} = request(method, path, query)

    labels
    |> Enum.filter(&(&1["name"] === status_name))
    |> hd()
    |> Map.get("id")
  end
end
