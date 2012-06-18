module Basil
  class Server
    include Logging

    def dispatch_message(msg)
      debug "dispatching #{msg.pretty}"
      ChatHistory.store_message(msg)

      if Config.dispatcher_type == :extended
        Dispatch.extended(msg)
      else
        Dispatch.simple(msg)
      end

    rescue Exception => ex
      error "#{ex}"

      nil
    end
  end
end
