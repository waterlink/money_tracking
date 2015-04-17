module MoneyTracking
  module Domain
    class Expense
      def initialize(store, fields)
        @store = store
        @fields = fields
      end

      def create
        @id = store.create(raw)
        self
      end

      def build_view(view_factory)
        view_factory.new(raw)
      end

      private

      attr_reader :store, :fields, :id

      def raw
        return fields unless id
        fields.merge(id: id)
      end
    end
  end
end
