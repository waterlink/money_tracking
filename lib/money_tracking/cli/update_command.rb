module MoneyTracking
  module Cli
    class UpdateCommand < Struct.new(:expense_finder, :expense_id, :amount, :currency, :add_tags, :rm_tags)
      def call
        expense
          .update(
            amount: amount,
            currency: currency,
            add_tags: add_tags,
            rm_tags: rm_tags,
          ).build_view(view_factory)
      end

      private

      def expense
        @_expense ||= expense_finder.read(expense_id)
      end

      def view_factory
        return Views::ExpenseNotUpdated unless updating?
        Views::ExpenseUpdated
      end

      def updating?
        [amount,
         currency,
         add_tags && !add_tags.empty?,
         rm_tags && !rm_tags.empty?].any?
      end
    end
  end
end
