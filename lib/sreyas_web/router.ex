defmodule SreyasWeb.Router do
  use SreyasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SreyasWeb.UserAuthController, repo: Sreyas.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SreyasWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", UserSessionController, only: [:new, :create, :delete]
    resources "/donors", DonorController
    resources "/donations", DonationController
    resources "/programs", ProgramController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SreyasWeb do
  #   pipe_through :api
  # end
end
