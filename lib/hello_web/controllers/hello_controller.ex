defmodule HelloWeb.HelloController do
  use HelloWeb, :controller

  plug HelloWeb.Plugs.Locale, "en" when action in [:index]
  # plug :authenticate
  # plug :fetch_message
  # plug :authorize_message

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"messenger" => messenger}) do
    # render(conn, "show.html", messenger: messenger)
    # text(conn, "From messenger #{messenger}")
    json(conn, %{id: messenger})
  end


  # def show(conn, params) do
  #   render(conn, :show, page: conn.assigns[:message])
  # end

  # defp authenticate(conn, _) do
  #   case Authenticator.find_user(conn) do
  #     {:ok, user} ->
  #       assign(conn, :user, user)
  #     :error ->
  #       conn |> put_flash(:info, "You must be logged in") |> redirect(to: "/") |> halt()
  #   end
  # end

  # defp fetch_message(conn, _) do
  #   case find_message(conn.params["id"]) do
  #     nil ->
  #       conn |> put_flash(:info, "That message wasn't found") |> redirect(to: "/") |> halt()
  #     message ->
  #       assign(conn, :message, message)
  #   end
  # end

  # defp authorize_message(conn, _) do
  #   if Authorizer.can_access?(conn.assigns[:user], conn.assigns[:message]) do
  #     conn
  #   else
  #     conn |> put_flash(:info, "You can't access that page") |> redirect(to: "/") |> halt()
  #   end
  # end

end