VIEWS = %w[
  empty expense_list expense_item expense_created
  expense_updated expense_deleted
]

module MoneyTracking
  module Cli
    module Views
      VIEWS.each do |view|
        require "money_tracking/cli/views/#{view}"
      end
    end
  end
end
