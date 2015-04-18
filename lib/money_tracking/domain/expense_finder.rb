module MoneyTracking
  module Domain
    class ExpenseFinder < Struct.new(:store, :expense_factory)
      def list
        store.list.map { |raw| expense_factory.build(raw) }
      end

      def read(expense_id)
        expense_factory.build(store.read(expense_id), expense_id)
      end
    end
  end
end
