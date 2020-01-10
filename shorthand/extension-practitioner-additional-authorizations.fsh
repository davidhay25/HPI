Extension: practitioner-additional-authorizations
Id: practitioner-additional-authorizations
Description:  "None supplied yet"

* extension contains
    auth 0..1 and
    periodXXX 0..1

// definitions of sub-extensions
* extension[auth].url = "auth"
* extension[auth] ^definition = "A code identifying the additional authorisations that a practitioner is authorised to perform"
* extension[auth].value[x] only CodeableConcept

* extension[periodXXX].url = "periodXXX"
* extension[periodXXX] ^definition = "The period the additional authorization is effective"
* extension[periodXXX].value[x] only Period
