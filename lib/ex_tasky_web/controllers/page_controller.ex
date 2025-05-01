defmodule ExTaskyWeb.PageController do
  use ExTaskyWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
