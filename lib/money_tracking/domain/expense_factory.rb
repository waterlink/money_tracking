module MoneyTracking
  module Domain
    class ExpenseFactory < Struct.new(:store)
      def create(raw_expense)
        build(raw_expense).create
      end

      def build(raw_expense, id = nil)
        return ExpenseNotFound.new unless raw_expense
        return build(raw_expense.merge(id: id)) if id
        Expense.new(store, raw_expense)
      end
    end
  end
end
