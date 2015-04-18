module MoneyTracking
  module Cli
    RSpec.describe DeleteCommand do
      subject { described_class.new(expense_finder, expense_id) }

      let(:expense_finder) { instance_double(Domain::ExpenseFinder) }
      let(:expense_id) { "ja6ptd3d" }
      let(:expense) { instance_double(Domain::Expense) }
      let(:not_found) { instance_double(Domain::ExpenseNotFound) }
      let(:view) { instance_double(Views::ExpenseDeleted) }
      let(:not_found_view) { instance_double(Views::ExpenseNotFound) }

      before do
        allow(expense).to receive(:build_view).with(Views::ExpenseDeleted).and_return(view)
        allow(expense).to receive(:delete).and_return(expense)

        allow(not_found).to receive(:build_view).with(Views::ExpenseDeleted)
                             .and_return(not_found_view)
        allow(not_found).to receive(:delete).and_return(not_found)
      end

      context "when no such expense found" do
        before { allow(expense_finder).to receive(:read).with(expense_id).and_return(not_found) }

        it "returns ExpenseNotFound view" do
          expect(subject.call).to be(not_found_view)
        end
      end

      context "when expense was found" do
        before { allow(expense_finder).to receive(:read).with(expense_id).and_return(expense) }

        it "returns ExpenseDeleted view" do
          expect(subject.call).to be(view)
        end

        it "deletes an expense" do
          expect(expense).to receive(:delete)
          subject.call
        end
      end
    end
  end
end
