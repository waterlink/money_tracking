module MoneyTracking
  module Cli::Views
    class ExpenseCreated < Struct.new(:expense)
      def to_s
        "Created new expense with id #{expense[:id]}."
      end
    end
  end
end
