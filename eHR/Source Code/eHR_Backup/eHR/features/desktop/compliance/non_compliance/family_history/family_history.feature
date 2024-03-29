#Name             : Family History
#Description      : Covers scenarios under Non Compliance related to Family History
#Author           : Mani.Sundaram

@all @non_compliance @non_compliance_family_history @milestone8
Feature: Non Compliance - Verification of Non Compliance Scenarios - Family History

  Background:
    Given login as "non ep"
    And set EP as "stage1 ep"

  @tc_1127
  Scenario: To Add Family History Status via Non Compliance Report
    Given a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "15 minutes" "before" the reporting period
    When the Non Compliance report for "today" is generated for "Family History" "related Non Compliance"
    Then "1" exam should "be" "present" in "Non Compliance report"
    And "1" "uncoded family history" is added for a exam in "non compliance report"
    Then "1" exam should "not be" "present" in "non compliance report"

    Given a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "20 minutes" "before" the reporting period
    When the Non Compliance report for "today" is generated for "Family History" "related Non Compliance"
    Then "1" exam should "be" "present" in "Non Compliance report"
    And "1" "coded family history" is added for a exam in "non compliance report"
    Then "1" exam should "not be" "present" in "non compliance report"

    Given a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "25 minutes" "before" the reporting period
    When the Non Compliance report for "today" is generated for "Family History" "related Non Compliance"
    Then "1" exam should "be" "present" in "Non Compliance report"
    And "1" "none known family history" is added for a exam in "non compliance report"
    Then "1" exam should "not be" "present" in "non compliance report"

  @tc_7409
  Scenario: To Add Family History Status via Non Compliance Report - Multiple visits for patient
    Given a patient is created "with MU"
    And "1" exam is created for the patient as "active" and "1 minute" "before" the reporting period
    And "1" exam is created for the patient as "active" and "1 day" "before" the reporting period
    When the Non Compliance report for "all" is generated for "Family History" "related Non Compliance"
    Then "2" exams should "be" "present" in "Non Compliance report"
    And "1" "none known family history" is added for a exam in "non compliance report"
    Then "2" exams should "not be" "present" in "non compliance report"