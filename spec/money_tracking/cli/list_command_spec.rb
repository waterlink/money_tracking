module MoneyTracking
  module Cli
    RSpec.describe ListCommand do
      subject { described_class.new(expense_finder) }

      let(:view) { double("View") }
      let(:expense_finder) { instance_double(Domain::ExpenseFinder) }
      let(:expenses) { [expense_a, expense_b] }

      let(:expense_a) { instance_double(Domain::Expense) }
      let(:expense_b) { instance_double(Domain::Expense) }

      context "when there are no expenses" do
        before { allow(expense_finder).to receive(:list).and_return([]) }

        it "returns empty view" do
          expect(subject.call).to be_a(Views::Empty)
        end
      end

      context "when there are some expenses" do
        before { allow(expense_finder).to receive(:list).and_return(expenses) }

        it "creates proper expense list view and returns it" do
          allow(Views::ExpenseList)
            .to receive(:new)
                 .with(expenses, Views::ExpenseItem)
                 .and_return(view)
          expect(subject.call).to be(view)
        end
      end
    end
  end
end
