defmodule Issues.Cli do
  @default_count 4

  import Issues.TableFormatter, only: [print_table_for_columns: 2]


  def run(argv) do
    argv
      |> parse_opts
      |> process
  end

  def parse_opts(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} ->
        :help
      {_, [user, project, count], _} ->
        {user, project, String.to_integer(count)}
      {_, [user, project], _} ->
        {user, project, @default_count}
      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [ <count> | #{@default_count} ]
    """

    System.halt(0)
  end

  def process({user, project, count}) do
    Issues.GithubIssues.fetch(user, project)
      |> decode_response
      |> Enum.take(count)
      # |> trace
      |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}) do
    body
  end

  def trace(x) do
    IO.puts x
    x
  end
  # def decode_response({:error, reason}) do
  #   System.has
  # end
end
