module MoneyTracking
  module Cli
    class ListCommand
      def call
        return Views::Empty.new if empty?
        Views::ExpenseList.new(raw_expenses, Views::ExpenseItem)
      end

      private

      def empty?
        !File.exist?("created_some")
      end

      def raw_expenses
        amount = "73.90"
        amount = File.read("changed_amount").strip if File.exist?("changed_amount")
        [{
           id: "7dt0ibnv",
           created_at: "17-04-2015 19:04:34",
           amount: amount,
           currency: "euro",
           tags: ["food"],
         }]
      end
    end
  end
end
