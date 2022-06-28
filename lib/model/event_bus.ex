defmodule Bookshelf.Model.EventBus do
  @callback publish(event :: String.t()) :: :ok
end
