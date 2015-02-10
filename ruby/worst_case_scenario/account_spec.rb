require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'active_support/core_ext/date'

Dir["./*.rb"].each {|file| require file }

describe Account do

  describe 'checking account' do

    before do 
      @account = Account.new(:checking, 1000, 0.01)
    end

    it 'withdraws' do
      @account.withdraw(300)
      @account.balance.must_equal 700
    end

    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

    it 'does not allow interest changes' do
      lambda {@account.interest_rate = 0.4}.must_raise(IllegalOperation)
    end

    it 'throws overdraw exception' do
      lambda {@account.withdraw(1001)}.must_raise(OverdrawException)
    end

  end

  describe 'savings account' do

    before do
      @account = Account.new(:savings, 1000, 0.01)
    end

    it 'withdraws' do
      @account.withdraw(300)
      @account.balance.must_equal 700
    end

    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

    it 'does not allow interest changes' do
      lambda {@account.interest_rate = 0.4}.must_raise(IllegalOperation)
    end

    it 'throws overdraw exception' do
      lambda {@account.withdraw(1001)}.must_raise(OverdrawException)
    end
  end

  describe 'CD account' do

    before do
      @account = Account.new(:cd, 1000, 0.01, Date.tomorrow)
    end

    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

    it 'errors on premature withdraws' do
      lambda {@account.withdraw(300)}.must_raise(ImmatureFundsException)
    end

    it 'does not allow interest changes' do
      lambda {@account.interest_rate = 0.4}.must_raise(IllegalOperation)
    end

    it 'throws overdraw exception' do
      lambda {@account.withdraw(1001)}.must_raise(OverdrawException)
    end
  end

  describe 'money market account' do
    before do
      @account = Account.new(:money_market, 1000, 0.01, nil, 200)
    end

    it 'deposits' do
      @account.deposit(300)
      @account.balance.must_equal 1300
    end

    it 'allows interest changes' do
      @account.interest_rate = 0.08
      @account.interest_rate.must_equal 0.08
    end

    it 'withdraws' do
      @account.withdraw(300)
      @account.balance.must_equal 700
    end

    it 'errors on balance < min balance' do
      lambda {@account.withdraw(900)}.must_raise(OverdrawException)
    end

    it 'throws overdraw exception' do
      lambda {@account.withdraw(1001)}.must_raise(OverdrawException)
    end

  end
end
