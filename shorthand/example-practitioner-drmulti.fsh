Instance:   drmulti
InstanceOf: HpiPractitioner


* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'> Dr Multi</div>"
* text.status = #additional

//the current HPI
* identifier[0].use = #official
* identifier[0].system = "https://standards.digital.health.nz/id/cpn"
* identifier[0].value = "98ZZA"

//a dormant HPI
* identifier[1].use = #old
* identifier[1].system = "https://standards.digital.health.nz/id/cpn"
* identifier[1].value = "98ZZB"

//the persons name
* name[0].text = "Dr Multi RA Example"
* name[0].family = "Multi"
* name[0].given[0] = "Frank"

* gender = #male
* birthDate = "1970-07-20"


//This qualification is actually thught of as a 'registration' by the HPI, but still recorded in the 'qualification' element...
//There's a single qualification, so no indexer ([]) is needed...
//NZMC number
* qualification.identifier.use = #official
* qualification.identifier.system = "https://standards.digital.health.nz/CodeSystem/nzmc-registration-authid"
* qualification.identifier.value = "123456"

//Is a qualified doctor
* qualification.code.coding.system = "http://standards.digital.health.nz/CodeSystem/registration-types"
* qualification.code.coding.code = #MD
* qualification.code.coding.display = "Medical doctor"

//period of qualification
* qualification.period.start = "2019-03-01"
* qualification.period.end = "2019-11-30"

//issuer. This uses the HPI identifier for the NZMC as the reference type rather than a 'real' FHIR reference
* qualification.issuer.identifier.system = "https://standards.digital.health.nz/id/hpi-organisation"
* qualification.issuer.identifier.value = "nzmc"

//The initial date for this registration
* qualification.extension[practitioner-qualification-initialDate].url = "http://hl7.org.nz/fhir/StructureDefinition/practitioner-qualification-initialDate"
* qualification.extension[practitioner-qualification-initialDate].valueDate = "2018-11-26"

//This is an active qualification
* qualification.extension[practitioner-qualification-status].valueCodeableConcept.coding.code = #active
* qualification.extension[practitioner-qualification-status].valueCodeableConcept.coding.system = "https://standards.digital.health.nz/CodeSystem/practitioner-qualificationstatus"

//there is a condition on practice
* qualification.extension[practitioner-conditions-on-practice].extension[description].valueString = "Dr Example  is permitted to practise medicine in the position of House Officer in accredited clinical attachments at Southern District Health Board under the supervision of an approved prevocational educational supervisor between 01 March 2019 and 30 November 2019. The purpose of this registration is to require doctors to meet Council requirements for registration in the general scope of practice."
* qualification.extension[practitioner-conditions-on-practice].extension[periodXXX].valuePeriod.start = "2018-11-26"
* qualification.extension[practitioner-conditions-on-practice].extension[periodXXX].valuePeriod.end = "2019-03-01"

//Scope of practice is MCPG
* qualification.extension[practitioner-scope-of-practice].extension[codeXXX].valueCodeableConcept.coding[0].code = #MCPG
* qualification.extension[practitioner-scope-of-practice].extension[codeXXX].valueCodeableConcept.coding[0].system = "https://standards.digital.health.nz/CodeSystem/practitioner-scopeofpractice"
* qualification.extension[practitioner-scope-of-practice].extension[periodXXX].valuePeriod.start = "2018-11-26"


