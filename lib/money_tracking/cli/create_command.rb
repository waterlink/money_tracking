module MoneyTracking
  module Cli
    class CreateCommand < Struct.new(:expense_factory, :amount, :currency, :tags)
      def call
        expense_factory
          .create(raw_expense)
          .build_view(Views::ExpenseCreated)
      end

      private

      def raw_expense
        {
          amount: amount.to_f,
          currency: currency,
          tags: tags,
        }
      end
    end
  end
end
