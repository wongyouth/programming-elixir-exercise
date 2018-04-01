defmodule Issues.GithubIssues do
  @user_agent [ {"User-Agent", "Elixir wongyouth@gmail.com"} ]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
      # |> trace
      |> HTTPoison.get(@user_agent, [recv_timeout: 2000])
      |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, res}) do
    {:ok, Poison.Parser.parse! res.body}
  end

  def handle_response({:error, exp}) do
    {:error, exp.reason}
  end

  def trace(string) do
    IO.puts string
    string
  end
end
