# frozen_string_literal: true

require "rails_helper"

describe Provider do
  context "fields" do
    it "validates presence" do
      expect(subject).to validate_presence_of(:name).with_message("You must enter a provider name")
      expect(subject).to validate_presence_of(:dttp_id).with_message("You must enter a DTTP ID in the correct format, like b77c821a-c12a-4133-8036-6ef1db146f9e")
      expect(subject).to validate_presence_of(:code).with_message("You must enter a provider code in the correct format, like 12Y")
    end

    it "validates format" do
      subject.dttp_id = "XXX"
      subject.code = "abcd 1234"
      subject.valid?
      expect(subject.errors[:dttp_id]).to include("You must enter a DTTP ID in the correct format, like b77c821a-c12a-4133-8036-6ef1db146f9e")
      expect(subject.errors[:code]).to include("You must enter a provider code in the correct format, like 12Y")
    end
  end

  context "validates dttp_id" do
    subject { create(:provider) }

    it "validates uniqueness" do
      expect(subject).to validate_uniqueness_of(:dttp_id).case_insensitive.with_message("You must enter a unique DTTP ID")
    end
  end

  describe "indexes" do
    it { should have_db_index(:dttp_id).unique(true) }
  end

  describe "associations" do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:apply_applications) }
    it { is_expected.to have_many(:courses) }
  end

  describe "auditing" do
    it { should be_audited }
    it { should have_associated_audits }
  end
end
