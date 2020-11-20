class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  attr_reader :transaction_executed
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @transaction_executed = false
  end

  def valid?
    return false if !(sender.valid?)
    return false if !(receiver.valid?)
    return true
  end

  def execute_transaction
    if @sender.balance >= @amount && @transaction_executed == false && valid?
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
      @transaction_executed = true
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      reverse = Transfer.new(@receiver, @sender, @amount)
      reverse.execute_transaction
      @status = "reversed"
    end
  end
end
