module MoneyTracking
  module Cli
    module Views
      class ExpenseItem < Struct.new(:expense)
        def to_s
          "#{id} - #{created_at}: #{amount} #{currency} #{tags}".strip
        end

        private

        def id; expense[:id] end
        def created_at; expense[:created_at] end
        def currency; expense[:currency] end

        def amount
          sprintf("%.2f", expense[:amount].to_f.round(2))
        end

        def tags
          return "" if expense[:tags].empty?
          "[#{expense[:tags].sort.join(" ")}]"
        end
      end
    end
  end
end
