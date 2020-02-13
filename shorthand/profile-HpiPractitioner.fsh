
Profile:        NzPractitioner
Parent:         Practitioner
Id:             NzPractitioner
Title:          "NZ Practitioner"
Description:    "The New Zeanand base practitioner. Sets common elements and extensions that all users should support."

* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>NZ Base Practitioner profile</div>"
* ^text.status = #additional

//top level  extensions
* extension contains 
    nzethnicity 0..4

//must be one name with a family name
* name 1..*
* name.family 1..1

//slice identifier to add the NHI as Must Support
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    HPI 0..1 MS 
* identifier[HPI].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[HPI].use = #official

Profile:        HpiPractitioner
Parent:         NzPractitioner
Id:             HpiPractitioner
Title:          "HPI Practitioner"
Description:    "The practitioner exposed by the HPI."

* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>HPI Practitioner profile</div>"
* ^text.status = #additional

* ^purpose = "Describe the Practitioner that will be returned by the HPI"

//elements that have been removed
* active 0..0
* telecom 0..0
* address 0..0
* photo 0..0

//top level  extensions
* extension contains 
    practitioner-deathdate 0..1 

//slice identifier to add none or more dormant NHI as Must Support
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    dormant 0..* MS
* identifier[dormant].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[dormant].use = #old

//the gender is required buy the HPI
* gender 1..1

//many extensions on qualification
* qualification.extension contains
    practitioner-qualification-status 0..1 and
    practitioner-additional-authorizations 0..* and
    practitioner-scope-of-practice 0..* and
    practitioner-conditions-on-practice 0..* and
    practitioner-qualification-initialDate 0..1

