# Description    : step definitions for steps related to patient creation and selection
# Author         : Chandra sekaran

# When a patient is created "with MU"
When /^a patient is created "([^"]*)"(?:| and preferred method of confidential communication as "([^"]*)")?$/  do |str_mu, str_communication_type|
  str_communication_type ||= ""
  $str_from_date, $report_generation_time = set_report_range("within report range") if $report_generation_time.nil?
  obj_next_day_time_at_12_am = Time.parse("#{($report_generation_time + 1.days).strftime(DATE_FORMAT_IN_YYYYMMDD)}")
  if ($report_generation_time + 5.minutes) >= obj_next_day_time_at_12_am
    if !@str_amc_field.nil?
      $log.info("Sleeping for 5 minutes due to difference reporting period day end")
      sleep 5.minutes
      step %{get "#{@str_amc_field}" details of "#{@str_amc_objective}" under "#{@str_amc_table}" for "#{$str_ep}" as "#{$str_report_range}"}
    end
  end
  on(EHR::MasterPage).select_menu_item(HOME)
  wait_for_loading
  click_on(on(EHR::SearchPatient).span_create_patient_element)

  on(EHR::CreatePatient) do |page|
    @str_patient_id = page.save_close_for_create_patient(str_mu, str_communication_type)
    wait_for_loading
  end
  raise "No such patient exist with id #{@str_patient_id}" if !on(EHR::SearchPatient).is_patient_exists(@str_patient_id)
  $log.success("Patient created successfully (#{@str_patient_id})")
  $arr_valid_exam_id = []
  $arr_all_exam_id = []
  $str_patient_id = @str_patient_id
  $arr_patient_id << @str_patient_id if $scenario_tags.include?("@non_compliance")
  $str_lab_order = ""

  $num_problem_list = 0
  $num_medication_allergy = 0
  $num_medication_list = 0
  $num_family_history  = 0
  $num_radiology_order = 0
  $num_laboratory_order = 0
  $num_s1_medication_order = 0
  $num_hand_written_medication_order = 0
  $num_s1_e_prescribed_medication_order = 0
  $num_s2_e_prescribed_medication_order = 0
  $num_clinical_lab_results = 0
  $num_s1_provide_clinical_summary = 0
  $num_s2_provide_clinical_summary = 0
  $num_s1_patient_electronic_access = 0
  $num_s2_patient_electronic_access = 0
  $num_transition_summary_of_care = 0
end

When /^the latest patient record is selected$/ do
  on(EHR::MasterPage).select_menu_item(HOME)
  on(EHR::SearchPatient) do |page|
    bool_patient_exist = page.search_patient("patient id", $str_patient_id)
    if bool_patient_exist
      page.select_patient
    else
      raise "No patient record found for patient id  : #{$str_patient_id}"
    end
  end
end




