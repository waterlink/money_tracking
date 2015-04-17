module MoneyTracking
  module Domain
    class ExpenseFactory < Struct.new(:store)
      def create(raw_expense)
        Expense.new(store, raw_expense).create
      end
    end
  end
end
