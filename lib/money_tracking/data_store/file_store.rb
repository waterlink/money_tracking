require "securerandom"
require "yaml"

module MoneyTracking
  module DataStore
    class FileStore < Protocol
      def initialize(dir)
        @dir = dir
        `mkdir -p #{dir}`
      end

      def create(fields)
        Record.new(dir, fields).save.id
      end

      def read(id)
        Record.new(dir).load(id).fields
      rescue Errno::ENOENT
        nil
      end

      def list
        Record.list(dir).map { |record| record.fields }
      end

      def update(id, fields)
        Record.new(dir).load(id).update(fields)
      end

      def delete(id)
        Record.new(dir).load(id).delete
      end

      private

      attr_accessor :dir

      class Record < Struct.new(:dir, :fields)
        def self.list(dir)
          Dir["#{dir}/*.yml"]
            .map { |path| File.basename(path, ".yml") }
            .map { |id| new(dir).load(id) }
        end

        def id
          @id ||= SecureRandom.hex(4)
        end

        def load(id)
          @id = id
          self.fields = YAML.load_file(filename).merge(id: id)
          self
        end

        def save
          File.open(filename, "w") { |f| f.write(to_yaml) }
          self
        end

        def update(fields)
          self.fields = fields
          save
        end

        def delete
          File.delete(filename)
        end

        private

        def to_yaml
          fields.to_yaml
        end

        def filename
          "#{dir}/#{id}.yml"
        end
      end
    end
  end
end
