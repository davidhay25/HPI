Extension: patient-birthPlace
Id: patient-birthPlace
Description:  "None supplied yet"

* extension contains
    countryXXX 0..1 and
    placeOfBirth 0..1 and
    source 0..1

// definitions of sub-extensions
* extension[countryXXX].url = "countryXXX"
* extension[countryXXX] ^definition = "The birth country."
* extension[countryXXX].value[x] only CodeableConcept
* extension[countryXXX].valueCodeableConcept from http://hl7.org/fhir/ValueSet/iso3166-1-2 (preferred)

* extension[placeOfBirth].url = "placeOfBirth"
* extension[placeOfBirth] ^definition = "No description"
* extension[placeOfBirth].value[x] only string

* extension[source].url = "source"
* extension[source] ^definition = "The source of information concerning the country of birth"
* extension[source].value[x] only CodeableConcept
* extension[source].valueCodeableConcept from http://standards.digital.health.nz/fhir/ValueSet/nzinfosource (required)
