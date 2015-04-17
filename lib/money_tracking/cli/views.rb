VIEWS = %w[
  empty expense_list expense_item expense_created
  expense_updated expense_deleted
]

VIEWS.each do |view|
  require "money_tracking/cli/views/#{view}"
end
