defmodule SreyasWeb.UserSessionController do
  use SreyasWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case SreyasWeb.UserAuthController.sign_in_with_username_and_password(conn, user, pass, repo: Sreyas.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username / password combination.")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> SreyasWeb.UserAuthController.sign_out()
    |> redirect(to: user_session_path(conn, :new))
  end

end
