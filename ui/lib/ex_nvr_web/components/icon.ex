defmodule ExNVRWeb.Components.Icon do
  @moduledoc false

  use Phoenix.Component

  attr :name, :string, required: true, doc: "Name of the icon (e.g., 'hero-home', 'svg-github')"
  attr :class, :string, default: nil
  attr :rest, :global

  @doc """
  Renders an icon, either a Heroicon or an SVG icon.

  ## Examples
      <.icon name="hero-home" />
      <.icon name="hero-cog" class="h-5 w-5" />
      <.icon name="svg-github" />
      <.icon name="svg-github" class="w-6 h-6 text-blue-500" />
  """
  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} {@rest} />
    """
  end

  def icon(%{name: "svg-github"} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="currentColor"
      class={["w-6 h-6 dark:text-gray-400", @class]}
      viewBox="0 0 640 640"
      aria-hidden="true"
    >
      <path d="M319.988 7.973C143.293 7.973 0 151.242 0 327.96c0 141.392 91.678 261.298 218.826 303.63 16.004 2.964 21.886-6.957 21.886-15.414 0-7.63-.319-32.835-.449-59.552-89.032 19.359-107.8-37.772-107.8-37.772-14.552-36.993-35.529-46.831-35.529-46.831-29.032-19.879 2.209-19.442 2.209-19.442 32.126 2.245 49.04 32.954 49.04 32.954 28.56 48.922 74.883 34.76 93.131 26.598 2.882-20.681 11.15-34.807 20.315-42.803-71.08-8.067-145.797-35.516-145.797-158.14 0-34.926 12.52-63.485 32.965-85.88-3.33-8.078-14.291-40.606 3.083-84.674 0 0 26.87-8.61 88.029 32.8 25.512-7.075 52.878-10.642 80.056-10.76 27.2.118 54.614 3.673 80.162 10.76 61.076-41.386 87.922-32.8 87.922-32.8 17.398 44.08 6.485 76.631 3.154 84.675 20.516 22.394 32.93 50.953 32.93 85.879 0 122.907-74.883 149.93-146.117 157.856 11.481 9.921 21.733 29.398 21.733 59.233 0 42.792-.366 77.28-.366 87.804 0 8.516 5.764 18.473 21.992 15.354 127.076-42.354 218.637-162.274 218.637-303.582 0-176.695-143.269-319.988-320-319.988l-.023.107z" />
    </svg>
    """
  end

  def icon(%{name: "network"} = assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
      class={["lucide lucide-network text-blue-600", @class]}
    >
      <rect x="16" y="16" width="6" height="6" rx="1"></rect>
      <rect x="2" y="16" width="6" height="6" rx="1"></rect>
      <rect x="9" y="2" width="6" height="6" rx="1"></rect>
      <path d="M5 16v-3a1 1 0 0 1 1-1h12a1 1 0 0 1 1 1v3"></path>
      <path d="M12 12V8"></path>
    </svg>
    """
  end
end
