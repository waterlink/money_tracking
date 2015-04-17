require "money_tracking"
require "money_tracking/cli/views"
require "money_tracking/cli/list_command"
require "money_tracking/cli/create_command"
require "money_tracking/cli/update_command"
require "money_tracking/cli/delete_command"

require "thor"

module MoneyTracking
  module Cli
    class Expenses < Thor
      desc "list", "List all expenses"
      def list
        render ListCommand.new.call
      end

      desc "create AMOUNT CURRENCY TAGS", "Creates an expense"
      def create(amount, currency, *tags)
        render CreateCommand.new(amount, currency, tags).call
      end

      desc "update EXPENSE_ID", "Updates an expense"
      method_option :amount, type: :numeric
      def update(expense_id)
        render UpdateCommand.new(expense_id, options.amount, nil, nil).call
      end

      desc "delete EXPENSE_ID", "Deletes an expense"
      def delete(expense_id)
        render DeleteCommand.new(expense_id).call
      end

      private

      def render(view)
        puts view.to_s
      end
    end

    class App < Thor
      desc "expenses", "Work with expenses, use money help expenses to get list of subcommands"
      subcommand "expenses", Expenses
    end
  end
end
