defmodule Notifier.HttpClient do
  @moduledoc false

  def api_key, do: Application.get_env(:notifier, :api_key)
  def api_token, do: Application.get_env(:notifier, :api_token)
  def api_version, do: Application.get_env(:notifier, :api_version)
  def base_url, do: Application.get_env(:notifier, :base_url)
  def board_id, do: Application.get_env(:notifier, :board_id)
  def scheme, do: Application.get_env(:notifier, :scheme)

  @doc false
  def request(method, path, query) do
    path = Path.join(["/", api_version(), path])
    credentials = %{"key" => api_key(), "token" => api_token()}
    query = Map.merge(query, credentials)

    url = %URI{
      scheme: scheme(),
      host: base_url(),
      port: 443,
      path: path,
      query: URI.encode_query(query)
    }

    options = [
      ssl: [
        {:versions, [:"tlsv1.2"]},
        verify: :verify_peer,
        cacerts: :public_key.cacerts_get(),
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ]
      ],
      timeout: 5_000,
      recv_timeout: 5_000
    ]

    headers = [{"Content-Type", "application/json"}]

    request = HTTPoison.request(method, url, "", headers, options)
    # request = HTTPoison.post(url, nil, headers, options)

    case request do
      {:ok, response} ->
        {:ok, Jason.decode!(response.body)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_list_id(list_name) do
    method = :get
    path = "boards/#{board_id()}/lists"
    query = %{}
    {:ok, lists} = request(method, path, query)

    lists
    |> Enum.filter(&(String.downcase(&1["name"]) === list_name))
    |> hd()
    |> Map.get("id")
  end

  def create_new_card(%{"name" => _, "desc" => _, "urlSource" => _} = query) do
    list_name = "todo"
    method = :post
    path = "cards"
    query = Map.put(query, "idList", get_list_id(list_name))

    {:ok, _} = request(method, path, query)

    :ok
  end
end
