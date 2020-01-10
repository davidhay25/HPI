Profile:        HPIPractitioner
Parent:         Practitioner
Id:             HpiPractitioner
Title:          "HPI Practitioner"
Description:    "The practitioner exposed by the HPI."

//* ^text.status = #additional
//* ^text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">text</div>"

* ^purpose = "Describe the Practitioner that will be returned by the HPI"

//elements that have been removed
* active 0..0
* telecom 0..0
* address 0..0
* photo 0..0

//top level  extensions
* extension contains 
    deathDate 0..1 and 
    nzethnicity 0..4

//identifier - current and dormant
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    HPI 0..1 MS and 
    dormant 0..* MS
* identifier[HPI].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[HPI].use = #official
* identifier[dormant].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[dormant].use = #old

* name 1..*
* name.family 1..1

* gender 1..1

* qualification.extension contains
    practitioner-qualification-status 0..1 and
    practitioner-additional-authorizations 0..* and
    practitioner-scope-of-practice 0..* and
    practitioner-conditions-on-practice 0..* and
    practitioner-qualification-initialDate 0..1

