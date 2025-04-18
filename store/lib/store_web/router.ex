defmodule StoreWeb.Router do
  use StoreWeb, :router

  import StoreWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {StoreWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StoreWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/home_admin_page", PageController, :home_admin
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
    put "/products/update/:id", ProductController, :update
    delete "/products/:id", ProductController, :delete

    get "/items", ItemController, :index
    get "/items/new", ItemController, :new
    post "/items", ItemController, :create
    get "/items/:id", ItemController, :show
    get "/items/:id/edit", ItemController, :edit
    put "/items/update/:id", ItemController, :update
    delete "/items/:id", ItemController, :delete

    get "/users", UserController, :index
    get "/users/new", UserController, :new
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update
    delete "/users/:id", UserController, :delete
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

  ## Authentication routes

  scope "/", StoreWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{StoreWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/user/register", UserRegistrationLive, :new
      live "/user/log_in", UserLoginLive, :new
      live "/user/reset_password", UserForgotPasswordLive, :new
      live "/user/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/user/log_in", UserSessionController, :create
  end

  scope "/", StoreWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{StoreWeb.UserAuth, :ensure_authenticated}] do
      live "/user/settings", UserSettingsLive, :edit
      live "/user/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", StoreWeb do
    pipe_through [:browser]

    delete "/user/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{StoreWeb.UserAuth, :mount_current_user}] do
      live "/user/confirm/:token", UserConfirmationLive, :edit
      live "/user/confirm", UserConfirmationInstructionsLive, :new

      live "/orders", OrderLive.Index, :index
      live "/orders/new", OrderLive.Index, :new
      live "/orders/:id/edit", OrderLive.Index, :edit

      live "/orders/:id", OrderShowLive.Show, :show
      live "/orders/:id/show/edit", OrderShowLive.Show, :edit
    end
  end
end
