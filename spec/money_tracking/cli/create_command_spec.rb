module MoneyTracking
  module Cli
    RSpec.describe CreateCommand do
      subject { described_class.new(expense_factory, "79.5", "euro", ["food", "other"]) }

      let(:expense_factory) { instance_double(Domain::ExpenseFactory) }
      let(:expense) { instance_double(Domain::Expense, build_view: nil) }
      let(:view) { instance_double(Views::ExpenseCreated) }

      before do
        allow(expense_factory)
          .to receive(:create).with(
                amount: 79.5,
                currency: "euro",
                tags: ["food", "other"],
              ).and_return(expense)
      end

      it "creates an expense object" do
        expect(expense_factory)
          .to receive(:create).with(
                amount: 79.5,
                currency: "euro",
                tags: ["food", "other"],
              ).and_return(expense)
        subject.call
      end

      it "renders ExpenseCreated view" do
        allow(expense)
          .to receive(:build_view)
               .with(Views::ExpenseCreated)
               .and_return(view)
        expect(subject.call).to eq(view)
      end
    end
  end
end
