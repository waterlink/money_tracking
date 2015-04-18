module MoneyTracking
  module Cli
    module Views
      class ExpenseNotFound < Struct.new(:expense)
        def to_s
          "Not found."
        end
      end
    end
  end
end
