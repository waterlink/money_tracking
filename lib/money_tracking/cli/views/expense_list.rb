module MoneyTracking
  module Cli::Views
    class ExpenseList < Struct.new(:expenses)
      def to_s
        expenses.map { |expense| ExpenseItem.new(expense).to_s + "\n" }
      end
    end
  end
end
