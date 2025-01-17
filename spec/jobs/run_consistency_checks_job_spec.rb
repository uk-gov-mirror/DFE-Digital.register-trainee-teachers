# frozen_string_literal: true

require "rails_helper"

describe RunConsistencyChecksJob do
  include ActiveJob::TestHelper

  let(:trainee) { create(:trainee) }
  let(:consistency_check) { create(:consistency_check, trainee_id: trainee.id) }

  before do
    consistency_check
  end

  describe ".perform" do
    it "runs each check" do
      ConsistencyCheck.all.each do |consistency_check|
        expect(Dttp::CheckConsistencyJob).not_to have_been_enqueued.with(consistency_check.id)
      end
    end
  end
end
