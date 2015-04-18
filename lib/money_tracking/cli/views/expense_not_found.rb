module MoneyTracking
  module Cli
    module Views
      class ExpenseNotFound < Struct.new(:expense)
        def initialize(expense)
          raise Error.new(self)
        end

        def to_s
          "Not found."
        end
      end
    end
  end
end
