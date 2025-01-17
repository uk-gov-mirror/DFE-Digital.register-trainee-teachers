# frozen_string_literal: true

TRAINING_ROUTE_ENUMS = {
  assessment_only: "assessment_only",
  early_years_undergrad: "early_years_undergrad",
  pg_teaching_apprenticeship: "pg_teaching_apprenticeship",
  provider_led_postgrad: "provider_led_postgrad",
  school_direct_salaried: "school_direct_salaried",
  school_direct_tuition_fee: "school_direct_tuition_fee",
}.freeze

TRAINING_ROUTES = {
  TRAINING_ROUTE_ENUMS[:assessment_only] => 0,
  TRAINING_ROUTE_ENUMS[:provider_led_postgrad] => 1,
  TRAINING_ROUTE_ENUMS[:early_years_undergrad] => 2,
  TRAINING_ROUTE_ENUMS[:school_direct_tuition_fee] => 3,
  TRAINING_ROUTE_ENUMS[:school_direct_salaried] => 4,
  TRAINING_ROUTE_ENUMS[:pg_teaching_apprenticeship] => 5,
}.with_indifferent_access.freeze
