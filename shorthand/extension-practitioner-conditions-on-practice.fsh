Extension: practitioner-conditions-on-practice
Id: practitioner-conditions-on-practice
Description:  "None supplied yet"

* extension contains
    description 0..1 and
    periodXXX 0..1

// definitions of sub-extensions
* extension[description].url = "description"
* extension[description] ^definition = "The condition on practice as text"
* extension[description].value[x] only string

* extension[periodXXX].url = "periodXXX"
* extension[periodXXX] ^definition = "The period the conditions on practice are effective"
* extension[periodXXX].value[x] only Period
