class TransferOperation
  include Wisper::Publisher

  def initialize(params)
    @params = params
    @account = Account.find(params[:id])
  end

  def call
  return broadcast(:failed, errors) if is_there_a_balance? == false
    broadcast(:success, transfer_operation)
  end

  def transfer_operation
    if is_there_a_balance?
      withdraw
      deposit
      fees
      schedules
    end
  end

  def fees
    if value_typed > 1000
      1000 + 10
    else
      1000
    end
  end

  def schedules
    time1 = '9:00am'
    time2 = '18:00pm'
    
    if time1 && time2
      value_typed + 5
    else
      value_typed + 7
    end
  end

  def is_there_a_balance?
    @account.balance >= value_typed
  end

  def withdraw
    @account.balance -= value_typed.to_f
  end

  def deposit
    @account.balance += value_typed.to_f
  end
end
