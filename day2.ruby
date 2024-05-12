require 'time'

module Logger
  def log_info(message)
    log_to_file("info", message)
  end

  def log_warning(message)
    log_to_file("warning", message)
  end

  def log_error(message)
    log_to_file("error", message)
  end

  private

  def log_to_file(log_type, message)
    timestamp = Time.now.iso8601
    log_entry = "#{timestamp} -- #{log_type} -- #{message}"
    File.open("file.log", "a") { |f| f.puts log_entry }
  end
end

class User
  attr_reader :name, :balance 

  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def update_balance(amount)
    if @balance + amount < 0
      raise "Not enough balance" 
    else
      @balance += amount
      if @balance == 0
        Logger.log_warning("#{@name} has 0 balance")
      end
    end
  end
end

class Transaction
  attr_reader :user, :value

  def initialize(user, value)
    @user = user
    @value = value
  end
end

class Bank
  def process_transactions(transactions, &callback)
    raise NotImplementedError, "This method must be implemented by subclasses" 
  end
end

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    log_info("Processing Transactions #{transactions.map { |t| "#{t.user.name} transaction with value #{t.value}" }.join(", ")}...")

    transactions.each do |transaction|
      begin
        if @users.include?(transaction.user)
          transaction.user.update_balance(transaction.value)
          log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
          callback.call("success", transaction) 
        else
          raise "#{transaction.user.name} not exist in the bank!!"
        end
      rescue StandardError => e 
        log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{e.message}")
        callback.call("failure", transaction, e.message)
      end
    end
  end
end

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]

cba_bank = CBABank.new(users)

cba_bank.process_transactions(transactions) do |status, transaction, reason=nil|
  if status == "success"
    puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value}"
  else
    puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} with reason #{reason}"
  end
end