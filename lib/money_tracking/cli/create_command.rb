module MoneyTracking
  module Cli
    class CreateCommand < Struct.new(:expense_factory, :store, :amount, :currency, :tags)
      def call
        #Views::ExpenseCreated.new(id: "7dt0ibnv")
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
