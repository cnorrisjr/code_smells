class Receipt
  attr_reader :items_sold, :business_address, :business_name

  def initialize(items_sold, business_name, business_address)
    @items_sold = items_sold
    @business_address = business_address
    @business_name = business_name
  end

  def to_s
    receipt_string = "#{@business_name}\n"
    receipt_string += "#{@business_address}\n"
    total = items_sold.inject(0) do |total_cost, (title, cost)|
      receipt_string += "#{title} \t\t #{cost}\n"
      total_cost += cost
    end
    receipt_string += "--------------------------\nTotal Cost: #{total}"
  end

  def write_to_file(filename)
    output = File.open(filename, 'w')
    output.print(to_s)
    output.close
  end

end
