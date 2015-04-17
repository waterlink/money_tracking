module MoneyTracking
  module Cli::Views
    RSpec.describe ExpenseItem do
      subject(:view) { 
        described_class.new(
          id: id,
          created_at: created_at,
          amount: amount,
          currency: currency,
          tags: tags,
        )
      }

      let(:id) { "go5775ft" }
      let(:created_at) { "14-04-2015 17:03:25" }
      let(:amount) { 47.39 }
      let(:currency) { "dollar" }
      let(:tags) { ["other"] }

      it "returns proper string representation" do
        expect(view.to_s)
          .to eq("go5775ft - 14-04-2015 17:03:25: 47.39 dollar [other]")
      end

      context "when number has more than 2 decimals after floating point" do
        let(:amount) { 33.9876 }
        it "rounds everything after 2 first decimals" do
          expect(view.to_s)
            .to eq("go5775ft - 14-04-2015 17:03:25: 33.99 dollar [other]")
        end
      end

      context "when number has less than 2 decimals after floating point" do
        let(:amount) { 33.7 }
        it "pads with zeros up to 2 decimals" do
          expect(view.to_s)
            .to eq("go5775ft - 14-04-2015 17:03:25: 33.70 dollar [other]")
        end
      end

      context "when there are no tags" do
        let(:tags) { [] }
        it "does not render them" do
          expect(view.to_s)
            .to eq("go5775ft - 14-04-2015 17:03:25: 47.39 dollar")
        end
      end

      context "when there are more tags" do
        let(:tags) { ["other", "food", "pricey"] }
        it "does render them in sorted order" do
          expect(view.to_s)
            .to eq("go5775ft - 14-04-2015 17:03:25: 47.39 dollar [food other pricey]")
        end
      end
    end
  end
end
