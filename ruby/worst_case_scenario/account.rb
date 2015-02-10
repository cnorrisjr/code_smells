class Account
  attr_reader :type, :balance, :maturation_date, :interest_rate, :minimum_balance

  def initialize(type, balance, interest_rate, maturation_date = nil, minimum_balance = nil)
    throw UnknownAccountType unless [:cd, :savings, :checking, :money_market].include?(type)
    @type = type
    @balance = balance
    @maturation_date = maturation_date
    @interest_rate = interest_rate
    @minimum_balance = minimum_balance
  end

  def withdraw(amount)
    raise OverdrawException if amount > @balance
    case @type
    when :cd
      raise ImmatureFundsException if (type == :cd && Date.today < @maturation_date)
    when :money_market
      raise OverdrawException if @balance - amount < @minimum_balance
    end
    @balance -= amount
  end

  def deposit(amount)
    @balance += amount
  end

  def interest_rate=(new_rate)
    case type
    when :money_market
      @interest_rate = new_rate
    else
      raise IllegalOperation
    end
  end
end

class ImmatureFundsException < RuntimeError
end
class OverdrawException < RuntimeError
end
class UnknownAccountType < RuntimeError
end
class IllegalOperation < RuntimeError
end
