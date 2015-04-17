require "money_tracking"
require "thor"

module MoneyTracking
  class Cli < Thor
    # Need to live here, since views want to be namespaced under Cli::Views
    require "money_tracking/cli/views"

    class Expenses < Thor
      desc "list", "List all expenses"
      def list
        if File.exist?("created_some")
          amount = "73.90"
          amount = File.read("changed_amount").strip if File.exist?("changed_amount")
          #puts "7dt0ibnv - 17-04-2015 19:04:34: #{amount} euro [food]"

          render Views::ExpenseList.new(
                   [{
                      id: "7dt0ibnv",
                      created_at: "17-04-2015 19:04:34",
                      amount: amount,
                      currency: "euro",
                      tags: ["food"],
                    }],
                   Views::ExpenseItem,
                 )
        else
          render Views::Empty.new
        end
      end

      desc "create AMOUNT CURRENCY TAGS", "Creates an expense"
      def create(amount, currency, *tags)
        `touch created_some`
        render Views::ExpenseCreated.new(id: "7dt0ibnv")
      end

      desc "update EXPENSE_ID", "Updates an expense"
      method_option :amount, type: :numeric
      def update(expense_id)
        `echo #{options.amount} > changed_amount`
        render Views::ExpenseUpdated.new(id: expense_id)
      end

      desc "delete EXPENSE_ID", "Deletes an expense"
      def delete(expense_id)
        `rm created_some`
        render Views::ExpenseDeleted.new(id: expense_id)
      end

      private

      def render(view)
        puts view.to_s
      end
    end

    desc "expenses", "Work with expenses, use money help expenses to get list of subcommands"
    subcommand "expenses", Expenses
  end
end
