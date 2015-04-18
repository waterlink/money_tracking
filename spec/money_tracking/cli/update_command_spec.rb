module MoneyTracking
  module Cli
    RSpec.describe UpdateCommand do
      subject { described_class.new(
        expense_finder,
        id,
        amount,
        currency,
        add_tags,
        rm_tags,
      ) }

      let(:expense_finder) { instance_double(Domain::ExpenseFinder) }
      let(:not_found) { instance_double(Domain::ExpenseNotFound) }
      let(:not_found_view) { instance_double(Views::ExpenseNotFound) }

      let(:view) { instance_double(Views::ExpenseUpdated) }
      let(:not_updated_view) { instance_double(Views::ExpenseNotUpdated) }

      let(:id) { "8ti0osfb" }
      let(:amount) { nil }
      let(:currency) { nil }
      let(:add_tags) { nil }
      let(:rm_tags) { nil }

      before { allow(not_found).to receive(:update).and_return(not_found) }

      context "when expense is not found" do
        before { allow(expense_finder).to receive(:read).with(id).and_return(not_found) }

        it "renders not found view" do
          allow(not_found)
            .to receive(:build_view)
                 .and_return(not_found_view)
          expect(subject.call).to be(not_found_view)
        end
      end

      context "when expense is found" do
        let(:expense) { instance_double(Domain::Expense) }

        before do
          allow(expense_finder).to receive(:read).with(id).and_return(expense)
          allow(expense).to receive(:update).and_return(expense)

          allow(expense)
            .to receive(:build_view)
                 .with(Views::ExpenseUpdated)
                 .and_return(view)

          allow(expense)
            .to receive(:build_view)
                 .with(Views::ExpenseNotUpdated)
                 .and_return(not_updated_view)
        end

        context "when there are no other options provided" do
          it "does nothing" do
            subject.call
          end

          it "renders ExpenseNotUpdated view" do
            expect(subject.call).to be(not_updated_view)
          end
        end

        context "when there was some options provided" do
          let(:amount) { 94.5 }
          let(:currency) { "dollar" }
          let(:add_tags) { ["food", "drinks"] }
          let(:rm_tags) { ["dinner"] }

          it "delegates to model's #update" do
            expect(expense)
              .to receive(:update)
                   .with(
                     amount: amount,
                     currency: currency,
                     add_tags: add_tags,
                     rm_tags: rm_tags,
                   ).and_return(expense)
            subject.call
          end

          it "returns ExpenseUpdated view" do
            expect(subject.call).to be(view)
          end
        end
      end
    end
  end
end
