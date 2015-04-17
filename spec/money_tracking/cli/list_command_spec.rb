module MoneyTracking
  module Cli
    RSpec.describe ListCommand do
      before { allow(File).to receive(:exist?).and_call_original }

      context "when there are no expenses" do
        before { allow(File).to receive(:exist?).with("created_some").and_return(false) }

        it "returns empty view" do
          expect(subject.call).is_a?(Views::Empty)
        end
      end

      context "when there are some expenses" do
        before { allow(File).to receive(:exist?).with("created_some").and_return(true) }

        it "returns empty view" do
          expect(subject.call).is_a?(Views::ExpenseList)
        end
      end
    end
  end
end
