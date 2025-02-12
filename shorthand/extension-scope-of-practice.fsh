Extension: Scope_of_practice
Id: scope-of-practice
Description: "The type or range of health services a practitioner is authorized to perform, as determined by the Responsible Authority or professional body."
//These files were generated by a script from a model at HpiPractitioner.qualification.scopeOfPractice

* extension contains
    codeXXX 0..1 and
    description 0..1 and
    periodXXX 0..1

// definitions of sub-extensions
* extension[codeXXX].url = "codeXXX"
* extension[codeXXX] ^definition = "A code identifying the services that the practitioner is permitted to perform"
* extension[codeXXX].value[x] only CodeableConcept
* extension[codeXXX].valueCodeableConcept from http://standards.digital.health.nz/fhir/ValueSet/scope-of-practice (preferred)

* extension[description].url = "description"
* extension[description] ^definition = "A full description of the health services that a health practitioner with this scope is permitted to perform"
* extension[description].value[x] only string

* extension[periodXXX].url = "periodXXX"
* extension[periodXXX] ^definition = "The period the scope of practice is effective"
* extension[periodXXX].value[x] only Period
