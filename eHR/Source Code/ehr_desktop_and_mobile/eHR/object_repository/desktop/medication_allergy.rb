=begin
  *Name               : MedicationAllergy
  *Description        : module to create / edit the medication allergy details in the health status screen
  *Author             : Gomathi
  *Creation Date      : 12/11/2014
  *Modification Date  :
=end

module EHR
  module HealthStatusTab
    module MedicationAllergy

      include PageObject
      include DataMagic
      include PageUtils

      # Page object details for create Allergy
      form(:form_create_allegy, :id => "createallergyform")
      select_list(:select_allergen, :id => "AllergyCode")
      text_field(:textfield_medication_name, :id => "MedicationCode_TextBox")
      div(:div_medication_ajax,            :xpath => "//div[@id='MedicationCode_container']/div")
      text_field(:textfield_specify_allergen, :id => "AllergyDesc")
      select_list(:select_severity, :id => "SeverityCode")
      select_list(:select_adverse_reaction, :id => "ReactionId")
      text_field(:textfield_diagnosed_date, :id => "felix-widget-calendar-AllergyDiagnosedStr-input")
      text_area(:textarea_description, :id => "Notes")

      button(:button_save_add_more_allergy, :xpath => "//form[@id='createallergyform']//button[@id='lnkCreateAllergy-button']")
      button(:button_save_close_allergy, :id => "lnkCreateCloseAllergy-button")
      button(:button_cancel_allergy, :id => "lnkClosecreateallergy-button")
      span(:span_medication_error, :id => "ermed") # Please select an existing Medication

      # Page object details for Edit Allergy
      select_list(:select_status, :id => "StatusCode")
      button(:button_save_close_edit_allergy, :xpath => "//form[@id='createallergyform']//button[@id='lnkCreateAllergy-button']")
      span(:span_cancel_edit_allergy, :xpath => "//form[@id='createallergyform']//div[2]/span[contains(@id,'createAllergyactionpannel')]")

      # Description        : Method to create allergy in health status screen
      # Author             : Gomathi
      # Arguments          :
      #   str_allergy      : string that denotes type of allergy
      #   str_allergy_node : root node of allergy data
      #
      def create_allergy(str_allergy, str_allergy_node)
        begin
          hash_allergy = set_scenario_based_datafile(MEDICATION_ALLERGY)

          str_medication_allergy = hash_allergy[str_allergy_node]["medication_allergey"]
          str_gadolinium_contrast_material_allergy = hash_allergy[str_allergy_node]["gadolinium_contrast_material_allergy"]
          str_iodine_contrast_material_allergy = hash_allergy[str_allergy_node]["iodine_contrast_material_allergy"]
          str_other_allergy = hash_allergy[str_allergy_node]["other_allergy"]
          str_coded_medication_name = hash_allergy[str_allergy_node]["coded_medication_name"]
          str_uncoded_medication_name = hash_allergy[str_allergy_node]["uncoded_medication_name"]
          str_severity = hash_allergy[str_allergy_node]["severity"]
          str_adverse_reaction = hash_allergy[str_allergy_node]["adverse_reaction"]

          case str_allergy.downcase
            when /coded medication allergen/
              select_allergen_element.select(str_medication_allergy)
              wait_for_object(textfield_medication_name_element, "Failure in finding textfield for medication name")
              self.textfield_medication_name = str_coded_medication_name
              wait_for_object(div_medication_ajax_element, "Failure in finding ajax for medication name list")
              sleep 1
              div_medication_ajax_element.list_item_elements(:xpath => ".//ul/li").each do |list_item|
                list_item.scroll_into_view rescue Exception
                if list_item.text.downcase.strip == str_coded_medication_name.downcase
                  list_item.click
                  break
                end
              end
              #textfield_medication_name_element.send_keys(:arrow_down) rescue Exception
              #sleep 1
              #textfield_medication_name_element.send_keys(:tab)
              if str_allergy.downcase.include?("with reaction and mild severity") || str_allergy.downcase.include?("with reaction and severe severity")
                select_severity_element.select(str_severity)
                select_adverse_reaction_element.select(str_adverse_reaction)
              end
            when "uncoded medication allergen"
              select_allergen_element.select(str_medication_allergy)
              wait_for_object(textfield_medication_name_element, "Failure in finding textfield for medication name")
              self.textfield_medication_name = str_uncoded_medication_name
              wait_for_object(div_medication_ajax_element, "Failure in finding ajax for medication name list")
              textfield_medication_name_element.send_keys(:tab)
            when "gadolinium contrast material allergy"
              select_allergen_element.select(str_gadolinium_contrast_material_allergy)
            when "iodine contrast material allergy"
              select_allergen_element.select(str_iodine_contrast_material_allergy)
            when "other allergy"
              select_allergen_element.select(str_other_allergy)
            else
              raise "invalid input for str_allergy : #{str_allergy}"
          end
          $world.puts("Test data : #{hash_allergy[str_allergy_node].to_s}")
          $log.success("data population for create allergy done successfully")
        rescue Exception => ex
          $log.error("Error while entering details of allergy (#{str_allergy}) : #{ex}")
          exit
        end
      end

      # description    : function to create a allergy
      # Author         : Gomathi
      # Arguments      :
      #   str_allergy  : string that denotes type of allergy
      #
      def save_close_create_allergy(str_allergy, str_allergy_node = "allergy_data")
        begin
          create_allergy(str_allergy, str_allergy_node)
          click_on(button_save_close_allergy_element)
        rescue Exception => ex
          $log.error("Error while creating an allergy (#{str_allergy}) : #{ex}")
          exit
        end
      end

      # description     : function to create more allergy
      # Author          : Gomathi
      # Arguments       :
      #   str_allergy   : string that denotes type of allergy
      #
      def save_add_more_create_allergy(str_allergy, str_allergy_node = "allergy_data")
        begin
          create_allergy(str_allergy, str_allergy_node)
          click_on(button_save_add_more_allergy_element)
        rescue Exception => ex
          $log.error("Error while creating the allergies (#{str_allergy}) : #{ex}")
          exit
        end
      end

    end
  end
end
