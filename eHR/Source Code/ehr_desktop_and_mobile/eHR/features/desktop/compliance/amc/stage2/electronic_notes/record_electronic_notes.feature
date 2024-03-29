#Name             : Record Electronic Notes
#Description      : covers scenarios under Record Electronic Notes feature for stage2
#Author           : Chandra sekaran

@all @s2_electronic_notes @stage2 @milestone1
Feature: AMC - Verification of Numerator and Denominator changes - Record Electronic Notes - Stage 2

  Background:
    Given login as "non EP"
    
  @tc_676 @tc_help_text
  Scenario: Verify Help text and Requirement column value for Record Electronic Notes stage 2 AMC
    Then get "requirement" details of "record electronic notes" under "menu set" for "stage2 ep" as "within report range"
    And the "requirement" of "record electronic notes" under "menu set" should be "equal" to "30"
    And get help text of "record electronic notes" under "menu set" from tooltip
    And help text for "record electronic notes" should be equal to the text
    """
    Enter at least one electronic progress note created, edited and signed by an EP for more than 30 percent of unique patients with at least one office visit during the EHR reporting period. The text of the electronic note must be text searchable and may contain drawings and other content
    """

  @tc_4793
  Scenario: Record Electronic Notes Stage 2 AMC measure does not account patients with inactive visit
    Then get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "within report range"
    When a patient is created "with MU"
    And "1" exam is created for the patient as "inactive" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

  @tc_4792
  Scenario: Record Electronic Notes Stage 2 AMC measure does not account Inpatients
    Then get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "within report range"
    When a patient is created "with MU"
    And "1" exam is created for the patient as "inpatient" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

  @tc_4791
  Scenario: Record Electronic Notes Stage 2 AMC measure does not account non face-to-face patients
    Then get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "within report range"
    When a patient is created "with MU"
    And "1" exam is created for the patient as "MU unchecked" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

  @tc_4790
  Scenario: Record Electronic Notes Stage 2 AMC measure does not account patients seen outside reporting period
    Then get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "outside report range"
    When a patient is created "with MU"
    And "1" exam is created for the patient as "1 day" "after" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

  @tc_678
  Scenario: Record Electronic Notes Stage 2 AMC measure does not account invalid visits
    Then get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "within report range"
    When a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When a patient is created "with MU"
    And "1" exam is created for the patient as "1 day" "after" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When a patient is created "with MU"
    And "1" exam is created for the patient as "MU unchecked" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When a patient is created "with MU"
    And "1" exam is created for the patient as "inpatient" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When a patient is created "with MU"
    And "1" exam is created for the patient as "inactive" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "0"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"

    When get "all" details of "record electronic notes" under "menu set" for "stage2 ep" as "outside report range"
    And a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    And a visit note is created for the exam
    Then the "numerator and denominator" of "record electronic notes" under "menu set" should be "increased" by "1"
    And "a record" should be in "record electronic notes" numerator report under "menu set"