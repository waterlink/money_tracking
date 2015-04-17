module MoneyTracking
  module Domain
    RSpec.describe Expense do
      subject(:expense) { described_class.new(store, fields) }

      let(:view_factory) { double("ViewFactory") }
      let(:view) { double("View") }
      let(:store) { instance_double(DummyStore, create: "7dt0ibnv") }
      let(:fields) { {
                       amount: 39.99,
                       currency: "dollar",
                       tags: ["food", "burgers"],
                     } }

      let(:raw_expense) { fields.merge(id: "7dt0ibnv") }

      describe "#create" do
        it "delegates to store" do
          expect(store)
            .to receive(:create)
                 .with(fields)
          expense.create
        end

        it "returns itself" do
          expect(expense.create).to be(expense)
        end
      end

      describe "#build_view" do

        context "when it is a new record" do
          before do
            allow(view_factory)
              .to receive(:new)
                   .with(fields)
                   .and_return(view)
          end

          it "gives relevant data to a view factory" do
            expect(view_factory)
              .to receive(:new)
                   .with(fields)
            expense.build_view(view_factory)
          end

          it "returns created view" do
            expect(expense.build_view(view_factory)).to be(view)
          end
        end

        context "when it is already saved record" do
          before do
            expense.create

            allow(view_factory)
              .to receive(:new)
                   .with(raw_expense)
                   .and_return(view)
          end

          it "gives relevant data with id to a view factory" do
            expect(view_factory)
              .to receive(:new)
                   .with(raw_expense)
            expense.build_view(view_factory)
          end

          it "returns created view" do
            expect(expense.build_view(view_factory)).to be(view)
          end
        end
      end
    end
  end
end
