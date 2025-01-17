# frozen_string_literal: true

require "rails_helper"

feature "edit trainee record", type: :feature do
  include TraineeHelper

  background do
    given_i_am_authenticated
    given_a_trainee_exists_with_a_degree
    when_i_visit_the_trainee_record_page
  end

  describe "about trainee view" do
    scenario "viewing the trainee's details" do
      then_i_see_the_trainee_name
      then_i_see_the_trn_status
      then_i_see_the_record_details
      then_i_see_the_course_details
    end
  end

  describe "personal details and education view" do
    scenario "viewing the trainee's personal details and education" do
      and_i_visit_the_personal_details
      then_i_see_the_personal_details
      then_i_see_the_contact_details
      then_i_see_the_diversity_details
      then_i_see_the_degree_details
    end
  end

  def given_a_trainee_exists_with_a_degree
    given_a_trainee_exists(:submitted_for_trn, degrees: [create(:degree, :uk_degree_with_details)])
  end

  def then_i_see_the_trainee_name
    expect(record_page.trainee_name.text).to include(trainee_name(trainee))
  end

  def then_i_see_the_trn_status
    state_text = "activerecord.attributes.trainee.states.#{trainee.state}"
    expect(record_page.trn_status.text).to eq("Status " + I18n.t(state_text).downcase)
  end

  def when_i_visit_the_trainee_record_page
    record_page.load(id: trainee.slug)
  end

  def then_i_see_the_record_details
    expect(record_page).to have_record_detail
  end

  def then_i_see_the_course_details
    expect(record_page).to have_course_detail
  end

  def and_i_visit_the_personal_details
    visit trainee_personal_details_path(trainee)
  end

  def then_i_see_the_personal_details
    expect(record_page).to have_personal_detail
  end

  def then_i_see_the_contact_details
    expect(record_page).to have_contact_detail
  end

  def then_i_see_the_diversity_details
    expect(record_page).to have_diversity_detail
  end

  def then_i_see_the_degree_details
    expect(record_page).to have_degree_detail
  end
end
