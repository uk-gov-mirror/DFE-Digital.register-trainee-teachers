# frozen_string_literal: true

require "rails_helper"

feature "edit trainee record", type: :feature do
  include TrnSubmissionsHelper

  background do
    given_i_am_authenticated
    given_a_trainee_exists(degrees: [create(:degree, :uk_degree_with_details)])
    when_i_visit_the_trainee_edit_page
  end

  describe "about trainee view" do
    scenario "viewing the trainee's details" do
      then_i_see_the_trainee_name
      then_i_see_the_trn_status
      then_i_see_the_record_details
      then_i_see_the_programme_details
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

    scenario "removing a degree" do
      and_i_visit_the_personal_details
      and_i_remove_the_degree
      then_i_should_not_see_any_degree
    end
  end

  def then_i_see_the_trainee_name
    expect(@edit_page.trainee_name.text).to include(trainee_name(trainee))
  end

  def then_i_see_the_trn_status
    expect(@edit_page.trn_status.text).to eq("Pending TRN")
  end

  def when_i_visit_the_trainee_edit_page
    @edit_page ||= PageObjects::Trainees::Edit.new
    @edit_page.load(id: trainee.id)
  end

  def then_i_see_the_record_details
    expect(@edit_page).to have_record_detail
  end

  def then_i_see_the_programme_details
    expect(@edit_page).to have_programme_detail
  end

  def and_i_visit_the_personal_details
    visit trainee_personal_details_path(trainee)
  end

  def then_i_see_the_personal_details
    expect(@edit_page).to have_personal_detail
  end

  def then_i_see_the_contact_details
    expect(@edit_page).to have_contact_detail
  end

  def then_i_see_the_diversity_details
    expect(@edit_page).to have_diversity_detail
  end

  def then_i_see_the_degree_details
    expect(@edit_page).to have_degree_detail
  end

  def and_i_remove_the_degree
    @edit_page.degree_detail.delete_degree.click
  end

  def then_i_should_not_see_any_degree
    expect(@edit_page.degree_detail.find_all(".govuk-summary-list__row")).to be_empty
  end
end