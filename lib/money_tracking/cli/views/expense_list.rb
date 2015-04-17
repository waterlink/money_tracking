module MoneyTracking
  module Cli
    module Views
      class ExpenseList < Struct.new(:expenses, :item_factory)
        def to_s
          expenses.map { |expense| expense.build_view(item_factory).to_s + "\n" }.join
        end
      end
    end
  end
end
