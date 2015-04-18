module MoneyTracking
  module Domain
    RSpec.describe ExpenseFinder do
      subject(:finder) { described_class.new(store, expense_factory) }

      let(:store) { instance_double(DummyStore) }
      let(:expense_factory) { instance_double(ExpenseFactory) }

      let(:raw_expenses) { [raw_a, raw_b, raw_c] }

      let(:raw_a) { double("raw a") }
      let(:raw_b) { double("raw b") }
      let(:raw_c) { double("raw c") }

      let(:expense_a) { double("expense a") }
      let(:expense_b) { double("expense b") }
      let(:expense_c) { double("expense c") }

      before do
        allow(expense_factory).to receive(:build).with(raw_a).and_return(expense_a)
        allow(expense_factory).to receive(:build).with(raw_b).and_return(expense_b)
        allow(expense_factory).to receive(:build).with(raw_c).and_return(expense_c)
      end

      describe "#list" do
        context "when store returns empty list" do
          before { allow(store).to receive(:list).and_return([]) }

          it "returns empty list too" do
            expect(finder.list).to be_empty
          end
        end

        context "when store returns some raw expenses" do
          before { allow(store).to receive(:list).and_return(raw_expenses) }

          it "returns a list of corresponding domain objects" do
            expect(finder.list).to eq([expense_a, expense_b, expense_c])
          end
        end
      end

      describe "#read" do
        let(:id) { "yvrz7h2r" }
        let(:raw_expense) { double("raw expense") }
        let(:expense) { instance_double(Expense) }

        before do
          allow(store).to receive(:read).with(id).and_return(raw_expense)
          allow(expense_factory).to receive(:build).with(raw_expense).and_return(expense)
        end

        it "delegates to store.read and builds expense from result" do
          expect(subject.read(id)).to be(expense)
        end
      end
    end
  end
end
