MODELS = %w[
  expense expense_factory expense_finder
]

MODELS.each do |model|
  require "money_tracking/domain/#{model}"
end

module MoneyTracking
  module Domain
  end
end
