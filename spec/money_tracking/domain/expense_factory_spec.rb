module MoneyTracking
  module Domain
    RSpec.describe ExpenseFactory do
      subject(:factory) { described_class.new(store) }

      let(:store) { double("Store", create: nil) }

      let(:raw_expense) { {
                            amount: 44.99,
                            currency: "euro",
                            tags: ["food", "other"],
                          } }

      let(:create_expense) { subject.create(raw_expense) }

      describe "#create" do
        it "creates an Expense" do
          expect(create_expense).to be_a(Expense)
        end

        it "delegates persistence to store" do
          expect(store)
            .to receive(:create)
                 .with(raw_expense)
          create_expense
        end
      end
    end
  end
end
