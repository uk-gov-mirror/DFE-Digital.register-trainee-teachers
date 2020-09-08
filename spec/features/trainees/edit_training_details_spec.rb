require "rails_helper"

feature "edit training details" do
  scenario "edit with valid parameters" do
    given_a_trainee_exists
    when_i_visit_the_training_details_page
    and_i_enter_valid_parameters
    then_i_am_redirected_to_the_summary_page
  end

  def given_a_trainee_exists
    @trainee = create(:trainee)
  end

  def when_i_visit_the_training_details_page
    @training_details_page ||= PageObjects::Trainees::TrainingDetails.new
    @training_details_page.load(id: @trainee.id)
  end

  def and_i_enter_valid_parameters
    set_date_fields("start_date", "10/01/2021")
    @training_details_page.full_time.click
    @training_details_page.teaching_scholars_yes.click
    @training_details_page.submit_button.click
  end

  def then_i_am_redirected_to_the_summary_page
    expect(page.current_path).to eq("/trainees/#{@trainee.id}")
  end

  def set_date_fields(field_prefix, date_string)
    day, month, year = date_string.split("/")
    @training_details_page.send("#{field_prefix}_day").set day
    @training_details_page.send("#{field_prefix}_month").set month
    @training_details_page.send("#{field_prefix}_year").set year
  end
end