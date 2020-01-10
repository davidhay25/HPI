Extension: practitioner-scope-of-practice
Id: practitioner-scope-of-practice
Description:  "None supplied yet"

* extension contains
    typeXXX 0..1 and
    description 0..1 and
    periodXXX 0..1

// definitions of sub-extensions
* extension[typeXXX].url = "typeXXX"
* extension[typeXXX] ^definition = "A code identifying the services that the practitioner is permitted to perform"
* extension[typeXXX].value[x] only CodeableConcept

* extension[description].url = "description"
* extension[description] ^definition = "A full description of the health services that a health practitioner with this scope is permitted to perform"
* extension[description].value[x] only string

* extension[periodXXX].url = "periodXXX"
* extension[periodXXX] ^definition = "The period the scope of practice is effective"
* extension[periodXXX].value[x] only Period
