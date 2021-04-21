# frozen_string_literal: true

TRAINING_ROUTE_ENUMS = {
  assessment_only: "assessment_only",
  early_years_assessment_only: "early_years_assessment_only",
  early_years_graduate_entry: "early_years_graduate_entry",
  early_years_graduate_placement: "early_years_graduate_placement",
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
  TRAINING_ROUTE_ENUMS[:early_years_assessment_only] => 6,
  TRAINING_ROUTE_ENUMS[:early_years_graduate_entry] => 7,
  TRAINING_ROUTE_ENUMS[:early_years_graduate_placement] => 8,
}.freeze

TRAINING_ROUTES_FOR_TRAINEE = TRAINING_ROUTES.select { |training_route|
  TRAINING_ROUTE_ENUMS.values_at(:assessment_only, :provider_led_postgrad, :early_years_undergrad).include? training_route
} .freeze

TRAINING_ROUTES_FOR_COURSE = TRAINING_ROUTES.select { |training_route|
  TRAINING_ROUTE_ENUMS.values_at(:provider_led_postgrad, :school_direct_tuition_fee, :school_direct_salaried, :pg_teaching_apprenticeship).include? training_route
} .freeze

TRAINING_ROUTE_FEATURE_FLAGS = TRAINING_ROUTE_ENUMS.keys.reject { |training_route|
  %i[assessment_only pg_teaching_apprenticeship].include? training_route
}.freeze
