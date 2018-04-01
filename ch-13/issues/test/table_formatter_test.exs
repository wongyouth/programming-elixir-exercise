defmodule TableFormatterTest do
  use ExUnit.Case
  # import ExUnit.CaptureIO

  alias Issues.TableFormatter, as: TF

  def simple_test_data do
    [
      %{
        "number" => 23,
        "created_at" => "2018-03-31T12:00:00Z",
        "title" => "first"
      },
      %{
        "number" => 22,
        "created_at" => "2018-03-30T12:00:00Z",
        "title" => "2dn"
      },
      %{
        "number" => 21,
        "created_at" => "2018-03-21T12:00:00Z",
        "title" => "3th"
      }
    ]
  end

  def headers, do: ["number", "created_at", "title"]

  def split_into_3_columns do
    TF.split_into_columns(simple_test_data(), headers())
  end


  test "split_into_columns" do
    columns = split_into_3_columns()

    # IO.puts columns

    assert length(columns) == length(headers())
  end

@data [
  %{
    "assignee" => nil,
    "assignees" => [],
    "author_association" => "NONE",
    "body" => "用的#10282帖子下载的#配置IPv6.bat成功开启了ipv6，也确实能联网了，youtube视频480P以下的基本流畅看没问题，720P比较卡。看了下状态，延迟有1000左右，见图，请问怎么能降低延迟呢？谢谢！\r\n![qq 20180331131355](https://user-images.githubusercontent.com/37948268/38159947-932a595c-34e6-11e8-9036-efeb5f48b859.jpg)\r\n",
    "closed_at" => nil,
    "comments" => 19,
    "comments_url" => "https://api.github.com/repos/XX-net/XX-Net/issues/10285/comments",
    "created_at" => "2018-03-31T05:22:40Z",
    "events_url" => "https://api.github.com/repos/XX-net/XX-Net/issues/10285/events",
    "html_url" => "https://github.com/XX-net/XX-Net/issues/10285",
    "id" => 310214120,
    "labels" => [],
    "labels_url" => "https://api.github.com/repos/XX-net/XX-Net/issues/10285/labels{/name}",
    "locked" => false,
    "milestone" => nil,
    "number" => 10285,
    "repository_url" => "https://api.github.com/repos/XX-net/XX-Net",
    "state" => "open",
    "title" => "开启ipv6后能联网了，但是延迟特别高1000左右，怎么破？",
    "updated_at" => "2018-03-31T08:36:53Z",
    "url" => "https://api.github.com/repos/XX-net/XX-Net/issues/10285",
    "user" => %{
      "avatar_url" => "https://avatars1.githubusercontent.com/u/37948268?v=4",
      "events_url" => "https://api.github.com/users/OP83/events{/privacy}",
      "followers_url" => "https://api.github.com/users/OP83/followers",
      "following_url" => "https://api.github.com/users/OP83/following{/other_user}",
      "gists_url" => "https://api.github.com/users/OP83/gists{/gist_id}",
      "gravatar_id" => "",
      "html_url" => "https://github.com/OP83",
      "id" => 37948268,
      "login" => "OP83",
      "organizations_url" => "https://api.github.com/users/OP83/orgs",
      "received_events_url" => "https://api.github.com/users/OP83/received_events",
      "repos_url" => "https://api.github.com/users/OP83/repos",
      "site_admin" => false,
      "starred_url" => "https://api.github.com/users/OP83/starred{/owner}{/repo}",
      "subscriptions_url" => "https://api.github.com/users/OP83/subscriptions",
      "type" => "User",
      "url" => "https://api.github.com/users/OP83"
    }
  }
]

  test "print_table_for_columns" do
    TF.print_table_for_columns(@data, headers())
  end
end
