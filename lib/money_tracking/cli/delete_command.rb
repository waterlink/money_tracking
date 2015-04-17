module MoneyTracking
  module Cli
    class DeleteCommand < Struct.new(:expense_id)
      def call
        `rm created_some`
        Views::ExpenseDeleted.new(id: expense_id)
      end
    end
  end
end
