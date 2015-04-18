require "money_tracking"
require "money_tracking/cli/views"
require "money_tracking/cli/commands"
require "money_tracking/data_store/file_store"

require "thor"

module MoneyTracking
  module Cli
    class Expenses < Thor
      desc "list", "List all expenses"
      def list
        render ListCommand.new(expense_finder).call
      end

      desc "create AMOUNT CURRENCY TAGS", "Creates an expense"
      def create(amount, currency, *tags)
        render CreateCommand.new(expense_factory, amount, currency, tags).call
      end

      desc "update EXPENSE_ID", "Updates an expense"
      method_option :amount, type: :numeric
      def update(expense_id)
        render UpdateCommand.new(expense_finder, expense_id, options.amount).call
      end

      desc "delete EXPENSE_ID", "Deletes an expense"
      def delete(expense_id)
        render DeleteCommand.new(expense_finder, expense_id).call
      end

      private

      def expense_factory
        Domain::ExpenseFactory.new(store)
      end

      def expense_finder
        Domain::ExpenseFinder.new(store, expense_factory)
      end

      def store
        @_store ||= DataStore::FileStore.new(file_store_dir)
      end

      def file_store_dir
        "#{user_home}/.money/expenses"
      end

      def user_home
        ENV.fetch("TEST_HOME", ENV["HOME"])
      end

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
