class Transaction
    attr_reader :user, :value
  
    def initialize(user, value)
      @user = user
      @value = value
    end
  end
  
  class Bank
    def self.process_transactions(transactions, users, &callback)
      raise NotImplementedError, "#{self.class}#process_transactions must be implemented in subclasses"
    end
  end
  
  class CBABank < Bank
    def self.process_transactions(transactions, users, &callback)
      transaction_details = transactions.map { |t| "User #{t.user.name} transaction with value #{t.value}" }.join(', ')
      Logger.log_info("Processing Transactions #{transaction_details}...")
  
      transactions.each do |transaction|
        begin
          if transaction.user.balance + transaction.value < 0
            raise "Not enough balance"
          elsif !users.include?(transaction.user)
            raise "#{transaction.user.name} not exist in the bank!!"
          else
            transaction.user.balance += transaction.value
            if transaction.user.balance == 0
              Logger.log_warning("#{transaction.user.name} has 0 balance")
            end
            Logger.log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
            callback.call("success", transaction)
          end
        rescue => e
          Logger.log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
          callback.call("failure", transaction)
        end
      end
    end
  end
  
  