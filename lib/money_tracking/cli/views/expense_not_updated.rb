module MoneyTracking
  module Cli
    module Views
      class ExpenseNotUpdated < Struct.new(:expense)
        def self.not_found
          self
        end

        def to_s
          "Not updated."
        end
      end
    end
  end
end
