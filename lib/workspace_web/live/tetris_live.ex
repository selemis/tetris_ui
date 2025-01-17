defmodule WorkspaceWeb.TetrisLive do
  use Phoenix.LiveView
  import Phoenix.HTML, only: [raw: 1]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, hello: :world, next: :key)}
  end

  def render(assigns) do
    ~L"""
    <h1><%= @hello %></h1>
    """
  end

end
