module MoneyTracking
  module Cli
    class UpdateCommand < Struct.new(:expense_id, :amount, :currency, :tags)
      def call
        `echo #{amount} > changed_amount`
        Views::ExpenseUpdated.new(id: expense_id)
      end
    end
  end
end
