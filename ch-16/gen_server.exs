defmodule GenServer do
  def start_link(server, state) do
    spawn_link server, :process, [state]
  end

  def call(pid, msg) do
    send pid, {msg, self()}
  end

  def procss(state) do
    receive do
      {msg, from} ->
        case handle_call(msg, from, state) do
          {:reply, reply_msg, new_state} ->
            send from, reply_msg
            process(new_state)

          {:noreply, state} ->
            process(new_state)
        end
    end
  end
end


defmodule Sequence.Server do
  
end
