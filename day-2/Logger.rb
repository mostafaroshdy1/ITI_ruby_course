module Logger
    def self.log_info(message)
      log("info", message)
    end
  
    def self.log_warning(message)
      log("warning", message)
    end
  
    def self.log_error(message)
      log("error", message)
    end
  
    def self.log(type, message)
      timestamp = DateTime.now.rfc3339
      log_message = "#{timestamp} -- #{type} -- #{message}"
      File.open("app.log", "a") { |file| file.puts(log_message) }
    end
  end
  