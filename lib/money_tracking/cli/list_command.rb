module MoneyTracking
  module Cli
    class ListCommand < Struct.new(:expense_finder)
      def call
        return Views::Empty.new if expenses.empty?
        Views::ExpenseList.new(expenses, Views::ExpenseItem)
      end

      private

      def expenses
        @_expenses ||= expense_finder.list
      end
    end
  end
end
