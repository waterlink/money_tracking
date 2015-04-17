module MoneyTracking
  module Cli
    module Views
      RSpec.describe ExpenseList do
        subject(:view) {
          described_class.new(
            expenses,
            expense_factory,
          )
        }

        let(:expenses) { [expense_a, expense_b, expense_c] }
        let(:expense_factory) { class_double(ExpenseItem) }

        let(:expense_a) { double("Raw expense a") }
        let(:expense_b) { double("Raw expense b") }
        let(:expense_c) { double("Raw expense c") }

        let(:item_a) { double("Item expense a", to_s: "an item a") }
        let(:item_b) { double("Item expense b", to_s: "an item b") }
        let(:item_c) { double("Item expense c", to_s: "an item c") }

        before do
          allow(expense_factory).to receive(:new).with(expense_a).and_return(item_a)
          allow(expense_factory).to receive(:new).with(expense_b).and_return(item_b)
          allow(expense_factory).to receive(:new).with(expense_c).and_return(item_c)
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
