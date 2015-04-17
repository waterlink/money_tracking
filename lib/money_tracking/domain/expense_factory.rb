module MoneyTracking
  module Domain
    class ExpenseFactory < Struct.new(:store)
      def create(raw_expense)
        build(raw_expense).create
      end

      def build(raw_expense)
        Expense.new(store, raw_expense)
      end
    end
  end
end
