Profile:        HpiPractitionerRole
Parent:         PractitionerRole
Id:             HpiPractitionerRole
Title:          "HPI Practitioner role"
Description:    "The practitioner role exposed by the HPI."


* ^purpose = "Describe the PractitionerRole that will be returned by the HPI"

//elements that have been removed
* active 0..0
* specialty 0..0
* healthcareService 0..0
* availableTime 0..0
* notAvailable 0..0
* availabilityExceptions 0..0

//top level  extensions
* extension contains 
    practitionerRole-status 0..1 and 
    practitionerRole-creator 0..1

    
/*
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

*/