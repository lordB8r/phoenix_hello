defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    # redirect(conn, to: Routes.page_path(conn, :redirect_test))
    # redirect(conn, external: "https://www.google.com")
    # redirect(conn, to: "/redirect_test")
    conn
    |> put_flash(:info, "Welcome to lordB8r's playground, from flash info!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> render("index.html")
    # |> put_layout("admin.html")             # render the normal stuff
    # |> render(:index)
    # |> put_resp_content_type("text/plain")  # intentionally render an error
    # |> send_resp(201, "")
    # |> put_status(202)
    # |> render("index.html")
  end

  def redirect_test(conn, _params) do
    render(conn, "index.html")
  end
end
