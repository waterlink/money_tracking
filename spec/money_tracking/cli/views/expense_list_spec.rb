module MoneyTracking
  module Cli
    module Views
      RSpec.describe ExpenseList do
        subject(:view) {
          described_class.new(
            expenses,
            item_factory,
          )
        }

        let(:expenses) { [expense_a, expense_b, expense_c] }
        let(:item_factory) { class_double(ExpenseItem) }

        let(:expense_a) { instance_double(Domain::Expense) }
        let(:expense_b) { instance_double(Domain::Expense) }
        let(:expense_c) { instance_double(Domain::Expense) }

        let(:item_a) { double("Item expense a", to_s: "an item a") }
        let(:item_b) { double("Item expense b", to_s: "an item b") }
        let(:item_c) { double("Item expense c", to_s: "an item c") }

        before do
          allow(expense_a).to receive(:build_view).with(item_factory).and_return(item_a)
          allow(expense_b).to receive(:build_view).with(item_factory).and_return(item_b)
          allow(expense_c).to receive(:build_view).with(item_factory).and_return(item_c)
        end

        it "renders proper list" do
          expect(view.to_s.split("\n"))
            .to eq([
                     "an item a",
                     "an item b",
                     "an item c",
                   ])
        end
      end
    end
  end
end
