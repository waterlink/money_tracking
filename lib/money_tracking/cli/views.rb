VIEWS = %w[empty expense_list expense_item]

VIEWS.each do |view|
  require "money_tracking/cli/views/#{view}"
end
