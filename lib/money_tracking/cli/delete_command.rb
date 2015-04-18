module MoneyTracking
  module Cli
    class DeleteCommand < Struct.new(:expense_finder, :expense_id)
      def call
        expense.delete.build_view(Views::ExpenseDeleted)
      end

      private

      def expense
        expense_finder.read(expense_id)
      end
    end
  end
end
