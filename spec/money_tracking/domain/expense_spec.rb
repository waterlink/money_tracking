module MoneyTracking
  module Domain
    RSpec.describe Expense do
      subject(:expense) { described_class.new(store, fields) }

      let(:view_factory) { double("ViewFactory") }
      let(:view) { double("View") }
      let(:store) { instance_double(DataStore::Protocol, create: "7dt0ibnv") }
      let(:fields) { {
                       amount: 39.99,
                       currency: "dollar",
                       tags: ["food", "burgers"],
                     } }

      let(:raw_expense) { fields.merge(id: "7dt0ibnv") }

      let(:fixed_time) { Time.now }

      describe "#create" do
        it "delegates to store with :created_at field = Time.now" do
          Timecop.freeze(fixed_time) do
            expect(store)
              .to receive(:create)
                   .with(fields.merge(created_at: fixed_time))
            expense.create
          end
        end

        it "returns itself" do
          expect(expense.create).to be(expense)
        end
      end

      describe "#update" do
        let(:fields) { super().merge(id: "qp5g0x0h") }
        let(:new_fields) { {
                             id: "qp5g0x0h",
                             amount: 49.99,
                             currency: "euro",
                             tags: ["food", "dinner", "pricey"]
                           } }
        let(:update_fields) { {
                                amount: 49.99,
                                currency: "euro",
                                add_tags: ["dinner", "pricey"],
                                rm_tags: ["burgers"],
                              } }

        it "adjusts its fields and sends them to store" do
          expect(store)
            .to receive(:update)
                 .with("qp5g0x0h", new_fields)
          expect(expense.update(update_fields)).to be(expense)
        end
      end

      describe "#delete" do
        let(:fields) { super().merge(id: "qp5g0x0h") }

        it "asks store to delete the record" do
          expect(store)
            .to receive(:delete)
                 .with("qp5g0x0h")
          expect(expense.delete).to be(expense)
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

    RSpec.describe ExpenseNotFound do
      describe "#build_view" do
        let(:view_factory) { double("View factory", not_found: not_found_factory) }
        let(:not_found_factory) { double("Not found factory", new: not_found_view) }
        let(:not_found_view) { double("Not found view") }

        it "builds not found view analogue" do
          expect(subject.build_view(view_factory)).to be(not_found_view)
        end
      end
    end
  end
end
