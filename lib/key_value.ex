defmodule Foo do
  defmodule A do
  end

  defmodule B do
  end

  defmodule C do
  end
end

defmodule KeyValue do
  @moduledoc """
  Documentation for `KeyValue`.
  """

  # alias
  alias Foo.A, as: FooA
  # shortcut for alias Foo.A, as: A
  alias Foo.A
  # multiple alias at the same time
  alias Foo.{A, B, C}

  # require <Module> --> import macros, code that writes code ( meta-programming )

  # use <Module>, option: :value --> require <Module> + <Module>.__using__(option: :value)

  # import <Module>, only: [...functions...], exclude: [...functions...] --> access to functions and macros without the module full name

  # alias, require, use and import are useful to manipulate nested modules which is bound to happen in any elixir application.

  @doc """
  Hello world.

  ## Examples

      iex> KeyValue.hello()
      :world

  """
  def hello do
    :world
  end

  defp it_is_time do
    :ok
  end
end
