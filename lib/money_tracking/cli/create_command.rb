module MoneyTracking
  module Cli
    class CreateCommand < Struct.new(:amount, :currencry, :tags)
      def call
        `touch created_some`
        Views::ExpenseCreated.new(id: "7dt0ibnv")
      end
    end
  end
end
