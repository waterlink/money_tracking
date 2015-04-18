module MoneyTracking
  module Cli
    module Views
      class ExpenseDeleted < Struct.new(:expense)
        def self.not_found
          ExpenseNotFound
        end

        def to_s
          "Deleted expense #{expense[:id]}."
        end
      end
    end
  end
end
