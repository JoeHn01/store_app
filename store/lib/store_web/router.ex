defmodule StoreWeb.Router do
  use StoreWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {StoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StoreWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/home_page", PageController, :home
    get "/menu_page", PageController, :menu
    get "/about_page", PageController, :about
    get "/products_page", PageController, :products
    get "/contact_page", PageController, :contact
    get "/signup_page", PageController, :signup
    get "/login_page", PageController, :login

    get "/products", ProductController, :index
    get "/products/new", ProductController, :new
    post "/products", ProductController, :create
    get "/products/:id", ProductController, :show
    get "/products/:id/edit", ProductController, :edit
    put "/products/:id", ProductController, :update
    delete "/products/:id", ProductController, :delete

    get "/items", ItemController, :index
    get "/items/new", ItemController, :new
    post "/items", ItemController, :create
    get "/items/:id", ItemController, :show
    get "/items/:id/edit", ItemController, :edit
    put "/items/:id", ItemController, :update
    delete "/items/:id", ItemController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", StoreWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:store, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: StoreWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
