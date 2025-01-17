# frozen_string_literal: true

require "rails_helper"

feature "edit personal details", type: :feature do
  background { given_i_am_authenticated }

  scenario "updates personal details with valid data" do
    given_valid_personal_details_are_provided
    then_the_personal_details_are_updated
  end

  scenario "updates personal details with 'other' nationality" do
    given_other_nationality_is_provided
    then_the_personal_details_are_updated
  end

  scenario "renders a completed status when valid personal details provided" do
    given_valid_personal_details_are_provided
    then_the_personal_details_section_should_be_completed
  end

  scenario "renders an 'in progress' status when valid personal details partially provided" do
    given_a_trainee_exists
    given_i_visited_the_review_draft_page
    and_nationalities_exist_in_the_system
    when_i_visit_the_personal_details_page
    and_i_enter_valid_parameters
    and_i_submit_the_form
    and_confirm_my_details(checked: false)
    then_i_am_redirected_to_the_review_draft_page
    then_the_personal_details_section_should_be_in_progress
  end

  scenario "does not update the personal details with invalid data" do
    given_a_trainee_exists
    and_nationalities_exist_in_the_system
    when_i_visit_the_personal_details_page
    and_i_submit_the_form
    then_i_see_error_messages
  end

  context "as a non-draft trainee" do
    before do
      given_a_trainee_exists(:submitted_for_trn)
      and_nationalities_exist_in_the_system
      given_i_visited_the_record_page
      when_i_visit_the_personal_details_page
      and_i_enter_valid_parameters
      and_i_submit_the_form
    end

    it "it doesn't ask me to complete the section" do
      then_the_confirm_details_page_has_no_checkbox
      and_i_click_continue
      then_i_am_redirected_to_the_record_page
      then_i_see_a_flash_message
    end
  end

private

  def given_valid_personal_details_are_provided
    given_a_trainee_exists
    given_i_visited_the_review_draft_page
    and_nationalities_exist_in_the_system
    when_i_visit_the_personal_details_page
    and_i_enter_valid_parameters
    and_i_submit_the_form
    and_confirm_my_details
    then_i_am_redirected_to_the_review_draft_page
  end

  def given_other_nationality_is_provided
    given_a_trainee_exists
    given_i_visited_the_review_draft_page
    and_nationalities_exist_in_the_system
    when_i_visit_the_personal_details_page
    and_i_enter_valid_parameters(other_nationality: true)
    and_i_submit_the_form
    and_confirm_my_details
    then_i_am_redirected_to_the_review_draft_page
  end

  def and_nationalities_exist_in_the_system
    @british ||= create(:nationality, name: "british")
    @french ||= create(:nationality, name: "french")
  end

  def when_i_visit_the_personal_details_page
    personal_details_page.load(id: trainee.slug)
  end

  def and_i_enter_valid_parameters(other_nationality: false)
    personal_details_page.first_names.set("Tim")
    personal_details_page.last_name.set("Smith")
    personal_details_page.set_date_fields("dob", "01/01/1986")
    personal_details_page.gender.choose("Male")

    if other_nationality
      personal_details_page.nationality.check("Other")
      personal_details_page.other_nationality.select(@french.name.titleize)
    else
      personal_details_page.nationality.check(@british.name.titleize)
    end
  end

  def and_confirm_my_details(checked: true)
    checked_option = checked ? "check" : "uncheck"
    expect(confirm_details_page).to be_displayed(id: trainee.slug, section: "personal-details")
    confirm_details_page.confirm.public_send(checked_option)
    and_i_click_continue
  end

  def then_the_confirm_details_page_has_no_checkbox
    expect(confirm_details_page).to_not have_text("I have completed this section")
  end

  def and_i_click_continue
    confirm_details_page.submit_button.click
  end

  def and_i_submit_the_form
    personal_details_page.continue_button.click
  end

  def then_the_personal_details_are_updated
    expect(trainee.reload.progress.personal_details).to be_truthy
  end

  def then_i_see_error_messages
    expect(personal_details_page).to have_content(
      I18n.t(
        "activemodel.errors.models.personal_details_form.attributes.nationality_ids.empty_nationalities",
      ),
    )
  end

  def then_the_personal_details_section_should_be_completed
    review_draft_page.load(id: trainee.slug)
    expect(review_draft_page.personal_details.status.text).to eq(completed)
  end

  def then_the_personal_details_section_should_be_in_progress
    review_draft_page.load(id: trainee.slug)
    expect(review_draft_page.personal_details.status.text).to eq(in_progress)
  end

  def then_i_see_a_flash_message
    expect(record_page).to have_text("Trainee personal details updated")
  end
end
