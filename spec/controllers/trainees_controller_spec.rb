require "rails_helper"

RSpec.describe TraineesController do
  describe "#show" do
    let(:trainee) { build(:trainee) }
    let(:id) { "1" }

    before do
      allow(Trainee).to receive(:find).with(id).and_return(trainee)
      get :show, params: { id: id }
    end

    it "returns 200" do
      expect(response).to be_successful
    end
  end

  describe "#new" do
    it "returns 200" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "#create" do
    let(:trainee_attributes) { attributes_for(:trainee_for_form) }
    let(:latest_trainee) { Trainee.last }

    before do
      post :create, params: { trainee: trainee_attributes }
    end

    it "creates record with correct data" do
      trainee_attributes.reject { |k, _| k.to_s.include?("date_of_birth") }.each do |k, _v|
        expect(latest_trainee.public_send(k)).to eql(trainee_attributes[k])
      end

      expect(latest_trainee.date_of_birth).to eql(
        Date.new(trainee_attributes[:"date_of_birth(1i)"].to_i,
                 trainee_attributes[:"date_of_birth(2i)"].to_i,
                 trainee_attributes[:"date_of_birth(3i)"].to_i),
      )
    end

    it "create record and redirects to show page" do
      expect(response).to redirect_to(trainee_path(latest_trainee))
    end
  end

  describe "#update" do
    let(:trainee) { create(:trainee) }
    let(:new_trainee_attributes) { attributes_for(:trainee_for_form) }
    let(:new_dob) do
      Date.new(new_trainee_attributes[:"date_of_birth(1i)"].to_i,
               new_trainee_attributes[:"date_of_birth(2i)"].to_i,
               new_trainee_attributes[:"date_of_birth(3i)"].to_i)
    end

    before do
      put :update, params: { id: trainee.id,
                             trainee: new_trainee_attributes }
    end

    it "tests for change in record" do
      trainee.reload

      expect(trainee.date_of_birth).to eql(new_dob)

      %i[
        first_names
        last_name
        gender
        nationality
        ethnicity
        disability
        a_level_1_subject
        a_level_1_grade
        a_level_2_subject
        a_level_2_grade
        a_level_3_subject
        a_level_3_grade
        degree_subject
        degree_class
        degree_institution
        degree_type
        ske
        previous_qts
      ].each do |field|
        expect(trainee.public_send(field)).to eql(new_trainee_attributes[field])
      end
    end
  end
end