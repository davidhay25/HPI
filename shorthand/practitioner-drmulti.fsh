Instance:   drmulti
InstanceOf: HpiPractitioner

* identifier[0].use = #official
* identifier[0].system = "https://standards.digital.health.nz/id/cpn"
* identifier[0].value = "98ZZA"

* identifier[0].use = #old
* identifier[0].system = "https://standards.digital.health.nz/id/cpn"
* identifier[0].value = "98ZZB"

* name[0].text = "Dr Multi RA Example"
* name[0].family = "Multi"
* name[0].given[0] = "Frank"

* gender = #male
* birthDate = "1970-07-20"

//The initial date for this registration
* qualification[0].extension[0].url = "http://hl7.org.nz/fhir/StructureDefinition/practitioner-qualification-initialDate"
* qualification[0].extension[0].valueDate = "2018-11-26"

//Scope of practice is MCPG
* qualification[0].extension[1].url = "http://hl7.org.nz/fhir/StructureDefinition/practitioner-scope-of-practice"
* qualification[0].extension[1].extension[0].url = "type"
* qualification[0].extension[1].extension[0].valueCodeableConcept.coding[0].code = #MCPG
* qualification[0].extension[1].extension[0].valueCodeableConcept.coding[0].system = "https://standards.digital.health.nz/CodeSystem/practitioner-scopeofpractice"
* qualification[0].extension[1].extension[0].valueCodeableConcept.text = "MCPG"
* qualification[0].extension[1].extension[1].url = "period"
* qualification[0].extension[1].extension[1].valuePeriod.start = "2018-11-26"

//there is a condition on practice
* qualification[0].extension[2].url = "http://hl7.org.nz/fhir/StructureDefinition/practitioner-conditions-on-practice"
* qualification[0].extension[2].extension[0].url = "description"
* qualification[0].extension[2].extension[0].valueString = "Dr Example  is permitted to practise medicine in the position of House Officer in accredited clinical attachments at Southern District Health Board under the supervision of an approved prevocational educational supervisor between 01 March 2019 and 30 November 2019. The purpose of this registration is to require doctors to meet Council requirements for registration in the general scope of practice."
* qualification[0].extension[2].extension[1].url = "period"
* qualification[0].extension[2].extension[1].valuePeriod.start = "2018-11-26"
* qualification[0].extension[2].extension[1].valuePeriod.end = "2019-03-01"

//This is an active qualification
* qualification[0].extension[3].url = "http://hl7.org.nz/fhir/StructureDefinition/practitioner-qualification-status"
* qualification[0].extension[3].valueCodeableConcept.coding[0].code = #active
* qualification[0].extension[3].valueCodeableConcept.coding[0].system = "https://standards.digital.health.nz/CodeSystem/practitioner-scopeofpractice"
* qualification[0].extension[3].valueCodeableConcept.coding[0].display = "active"

//The NZMC number
* qualification[0].identifier[0].use = #official
* qualification[0].identifier[0].system = "https://standards.digital.health.nz/CodeSystem/nzmc-registration-authid"
* qualification[0].identifier[0].value = "123456"

//Is a qualified doctor
* qualification[0].code.coding[0].system = "http://standards.digital.health.nz/CodeSystem/registration-types"
* qualification[0].code.coding[0].code = #MD
* qualification[0].code.coding[0].display = "Medical doctor"

//period of qualification
* qualification[0].period.start = "2019-03-01"
* qualification[0].period.end = "2019-11-30"

//issuer. This uses the HPI identifier for the NZMC as the reference type rather than a 'real' FHIR reference
* qualification[0].issuer.identifier.system = "https://standards.digital.health.nz/id/hpi-organisation"
* qualification[0].issuer.identifier.value = "nzmc"