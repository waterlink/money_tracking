module MoneyTracking
  module Cli
    module Views
      class ExpenseDeleted < Struct.new(:expense)
        def to_s
          "Deleted expense #{expense[:id]}."
        end
      end
    end
  end
end
