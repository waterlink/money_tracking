RSpec.shared_context "acts as a DataStore" do |options|
  store_reset = options.fetch(:store_reset, -> {})

  before { store_reset.call }
  after { store_reset.call }

  shared_examples "returns nil" do
    it "returns nil" do
      is_expected.to eq(nil)
    end
  end

  shared_examples "returns empty record set" do
    it "returns empty record set" do
      is_expected.to be_empty
    end
  end

  describe "#create" do
    subject { store.create(fields) }
    let(:fields) { { hello: "world", test: 35, some: [1, 2, "3"] } }

    it "returns unique id of created record" do
      is_expected.to match(/^[\d\w]{8}$/)
    end
  end

  describe "#read" do
    subject { store.read(id) }
    let(:id) { "some id" }

    context "when there was some records created" do
      let(:fields_a) { { hello: "world", test: 99 } }
      let(:fields_b) { { crazy: "stuff", amount: 89.5, tags: ["hello", "world"] } }
      let(:fields_c) { { lonely: "field" } }

      let!(:id_a) { store.create(fields_a) }
      let!(:id_b) { store.create(fields_b) }
      let!(:id_c) { store.create(fields_c) }

      let(:id) { id_b }

      it "returns fields of the record with specified id" do
        is_expected.to eq(fields_b)
      end

      context "but record with specified id doesn't exist" do
        let(:id) { "other id" }

        include_examples "returns nil"
      end

      context "and was deleted afterwards" do
        before { store.delete(id) }

        include_examples "returns nil"
      end

      context "and was updated with new fields" do
        before { store.update(id, new_fields) }

        let(:new_fields) { fields_b.merge(amount: 44, hello: "world") }

        it "returns updated fields of the record with specified id" do
          is_expected.to eq(new_fields)
        end
      end
    end

    context "when record wasn't created" do
      include_examples "returns nil"
    end
  end

  describe "#list" do
    subject { store.list.to_set }

    context "when there was no record created" do
      include_examples "returns empty record set"
    end

    context "when there was some records created" do
      let(:fields_a) { { hello: "world", test: 99 } }
      let(:fields_b) { { crazy: "stuff", amount: 89.5, tags: ["hello", "world"] } }
      let(:fields_c) { { lonely: "field" } }
      let(:fields_d) { { user: 79, name: "john" } }

      let!(:id_a) { store.create(fields_a) }
      let!(:id_b) { store.create(fields_b) }
      let!(:id_c) { store.create(fields_c) }
      let!(:id_d) { store.create(fields_d) }

      it "returns all these records" do
        is_expected.to eq([fields_a, fields_b, fields_c, fields_d].to_set)
      end

      context "and some records were updated" do
        before do
          store.update(id_a, new_fields_a)
          store.update(id_c, new_fields_c)
        end

        let(:new_fields_a) { fields_a.merge(lazy: "programmer", pragmatic: "programmer") }
        let(:new_fields_c) { fields_c.merge(amount: 44, hello: "world") }

        it "returns all these records with updated fields" do
          is_expected.to eq([new_fields_a, fields_b, new_fields_c, fields_d].to_set)
        end
      end

      context "and some records were deleted" do
        before do
          store.delete(id_b)
          store.delete(id_c)
        end

        it "returns all the records that are left" do
          is_expected.to eq([fields_a, fields_d].to_set)
        end
      end

      context "and all records were deleted" do
        before do
          store.delete(id_a)
          store.delete(id_b)
          store.delete(id_c)
          store.delete(id_d)
        end

        include_examples "returns empty record set"
      end
    end
  end
end
