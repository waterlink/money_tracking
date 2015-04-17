MODELS = %w[
  expense expense_factory
]

MODELS.each do |model|
  require "money_tracking/domain/#{model}"
end

module MoneyTracking
  module Domain
  end
end
