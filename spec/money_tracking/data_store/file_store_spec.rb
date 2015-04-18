require "money_tracking/data_store/file_store"
require_relative "acts_as_a_data_store"

module MoneyTracking
  module DataStore
    TEMP_FOLDER = "./tmp/expenses/"

    RSpec.describe FileStore do
      include_context "acts as a DataStore", store_reset: -> {
        `[ -d #{TEMP_FOLDER} ] && rm -r #{TEMP_FOLDER}`
      }

      subject(:store) { FileStore.new(TEMP_FOLDER) }
    end
  end
end
