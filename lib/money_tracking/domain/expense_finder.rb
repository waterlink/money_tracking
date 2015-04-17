module MoneyTracking
  module Domain
    class ExpenseFinder < Struct.new(:store, :expense_factory)
      def list
        store.list.map { |raw| expense_factory.build(raw) }
      end
    end
  end
end
