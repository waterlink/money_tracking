module MoneyTracking
  module Domain
    class Expense
      SIMPLE_FIELDS = %i[amount currency]

      def initialize(store, fields)
        @store = store
        @fields = fields
        @id = fields[:id]
      end

      def create
        set_created_at
        @id = store.create(raw)
        self
      end

      def update(updated_fields)
        simple_update(updated_fields)
        update_tags(updated_fields)
        store.update(id, raw)
        self
      end

      def delete
        store.delete(id)
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

      def set_created_at
        fields[:created_at] ||= Time.now
      end

      def simple_update(updated_fields)
        SIMPLE_FIELDS.each do |name|
          fields[name] = updated_fields[name] if updated_fields[name]
        end
      end

      def update_tags(updated_fields)
        fields[:tags] = TagUpdate.new(
          fields[:tags],
          updated_fields[:add_tags],
          updated_fields[:rm_tags],
        ).value
      end

      class TagUpdate < Struct.new(:tags, :add_tags, :rm_tags)
        def value
          tags - rm_tags + add_tags
        end

        private

        def rm_tags
          super || []
        end

        def add_tags
          super || []
        end
      end
    end

    class ExpenseNotFound
      def build_view(view_factory)
        view_factory.not_found.new(self)
      end

      def update(updated_fields)
        self
      end

      def delete
        self
      end
    end
  end
end
