module MoneyTracking
  module Cli
    module Views
      class ExpenseUpdated < Struct.new(:expense)
        def to_s
          "Updated expense #{expense[:id]}."
        end
      end
    end
  end
end
