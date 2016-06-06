require 'test_helper'

class DiagnosisImporterTest < Minitest::Test
  def test_diagnosis_importing
    doc = Nokogiri::XML(File.new('test/fixtures/cat1_fragments/diagnosis_fragment.xml'))
    doc.root.add_namespace_definition('cda', 'urn:hl7-org:v3')
    nrh = HealthDataStandards::Import::CDA::NarrativeReferenceHandler.new
    nrh.build_id_map(doc)
    diag = HealthDataStandards::Import::Cat1::EntryPackage.new(HealthDataStandards::Import::Cat1::DiagnosisImporter.new, '2.16.840.1.113883.10.20.28.3.110')
    diagnoses = diag.package_entries(cat1_patient_data_section(doc), nrh)
    diagnosis = diagnoses[0]
    severity = { 'code_system' => 'SNOMED-CT', 'code' => '55561003'}
    assert diagnosis.codes['ICD-9-CM'].include?("999.34")
    expected_start = HealthDataStandards::Util::HL7Helper.timestamp_to_integer('19890903081502')
    expected_end = HealthDataStandards::Util::HL7Helper.timestamp_to_integer('19890904034509')
    assert_equal expected_start, diagnosis.start_time
    assert_equal expected_end, diagnosis.end_time
    assert_equal  severity , diagnosis.severity
  end
end