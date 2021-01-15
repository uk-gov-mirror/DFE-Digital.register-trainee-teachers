# frozen_string_literal: true

require "rails_helper"

describe "Trainee state transitions" do
  describe "#update_and_receive_trn!" do
    let(:old_trn) { "123" }
    let(:new_trn) { "abc" }

    context "with a :submitted_for_trn trainee" do
      let(:trainee) { create(:trainee, :submitted_for_trn) }

      it "transitions the trainee to :trn_received and updates the trn" do
        trainee.update_and_receive_trn!(new_trn)
        expect(trainee.state).to eq("trn_received")
        expect(trainee.trn).to eq(new_trn)
      end
    end

    context "with a :deferred trainee" do
      context "with an existing trn" do
        let(:trainee) { create(:trainee, :deferred, trn: old_trn) }

        it "transitions the trainee to :trn_received" do
          trainee.update_and_receive_trn!
          expect(trainee.state).to eq("trn_received")
          expect(trainee.trn).to eq(old_trn)
        end
      end

      context "without an existing trn" do
        let(:trainee) { create(:trainee, :deferred) }
        it "raises an error if no trn is provided" do
          expect {
            trainee.update_and_receive_trn!
          }.to raise_error(StateTransitionError)
        end

        it "transitions the trainee to :trn_received and updates the trn" do
          trainee.update_and_receive_trn!(new_trn)
          expect(trainee.state).to eq("trn_received")
          expect(trainee.trn).to eq(new_trn)
        end
      end
    end

    context "with a :deferred trainee with an existing trn" do
      let(:trainee) { create(:trainee, :deferred, trn: old_trn) }

      it "transitions the trainee to :trn_received" do
        trainee.update_and_receive_trn!
        expect(trainee.state).to eq("trn_received")
        expect(trainee.trn).to eq(old_trn)
      end
    end

    (Trainee.states.keys - %w[submitted_for_trn deferred]).each do |state|
      context "with a :#{state} trainee" do
        let(:trainee) { create(:trainee, state) }

        it "raises an error" do
          expect {
            trainee.update_and_receive_trn!(new_trn)
          }.to raise_error(RuntimeError, "Invalid transition")
        end
      end
    end
  end

  describe "#update_and_submit_for_trn!" do
    let(:dttp_id) { SecureRandom.uuid }
    let(:placement_assignment_dttp_id) { SecureRandom.uuid }

    context "with a :draft trainee" do
      let(:trainee) { create(:trainee, :draft) }

      it "transitions the trainee to :submitted_for_trn and updates the dttp_id, placement_assignment_dttp_id and submitted_for_trn_at" do
        trainee.update_and_submit_for_trn!(dttp_id, placement_assignment_dttp_id)
        expect(trainee.state).to eq("submitted_for_trn")
        expect(trainee.dttp_id).to eq(dttp_id)
        expect(trainee.placement_assignment_dttp_id).to eq(placement_assignment_dttp_id)
        expect(trainee.submitted_for_trn_at).to_not be_nil
      end
    end
  end
end