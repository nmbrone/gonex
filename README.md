# Gonex - get your Phoenix variables in your Javascript

[![Actions Status](https://github.com/nmbrone/gonex/workflows/Elixir/badge.svg?branch=master)](https://github.com/nmbrone/gonex/actions)

Gonex is a super simple implementation of [gon](https://github.com/gazay/gon) but for [Phoenix](https://www.phoenixframework.org/) 
projects and it's a convenient way to send some data from your controller to your JavaScript.

## Installation

The package can be installed by adding `gonex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gonex, "~> 0.1.0"}
  ]
end
```

## Usage

First in your layout view:

```elixir
defmodule MyAppWeb.LayoutView do
  use MyAppWeb, :view
  
  # Import Gonex view helpers
  import Gonex.View
  
  def render("app.html", assigns) do
    ~E"""
    <!-- ... -->
    <%= render_gon(assigns.conn, "myAppGon") %>
    <!-- ... -->
    """
  end
end
```

Then in your controller:

```elixir
defmodule MyAppWeb.PageController do
  use MyAppWeb, :controller
  
  # Import Gonex controller helpers.
  # Alternatively you can import this in your MyAppsWeb :controller definition 
  # and make Gonex available within all of your controllers
  import Gonex.Controller
  
  def index(conn, _params) do
    conn
    |> put_gon(greeting: "Hello, World!") # put something useful here
    |> render("index.html")
  end
end
```

Finally in you JavaScript:

```javascript
alert(window.myAppGon.greeting); // "Hello, World!"
```

Sometimes you will need to have a basic (or initial) set of variables across all of your pages. 
This can be easily achieved with the custom plug:

```elixir
defmodule MyAppWeb.Plug.PutGon do
  def init(opts), do: opts
  
  def call(conn, _opts) do
    Gonex.Controller.put_gon(conn, %{
      env: Application.get_env(:my_app, :env),
      locale: Gettext.get_locale(MyAppWeb.Gettext)
    })
  end
end
```

Then in your router:

```elixir
defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :browser do
    # ...
    plug MyAppWeb.Plug.PutGon
    # ...
  end
end
```

## Documentation

The docs can be found at [https://hexdocs.pm/gonex](https://hexdocs.pm/gonex).

