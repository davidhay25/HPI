
Profile:        NzLocation
Parent:         Location
Id:             NzLocation
Title:          "NZ Location"
Description:    "NZ base Location"

* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>NZ Location profile</div>"
* ^text.status = #additional

//slice the identifier
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd

* identifier contains 
    facId 0..1 MS 
* identifier[facId].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[facId].use = #official

/*
//================================================================================

Profile:        HpiLocation
Parent:         NzLocation
Id:             HpiLocation
Title:          "HPI Location"
Description:    "Locations used by the HPI."

* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>HPI Location profile</div>"
* ^text.status = #additional

* ^purpose = "Describe the Location that will be returned by the HPI"

//elements that have been removed
* operationalStatus 0..0
* mode 0..0
* physicalType 0..0
* hoursOfOperation 0..0
* availabilityExceptions 0..0

//top level  extensions
* extension contains 
    hpiLocation-established 0..1 and
    hpiLocation-dhb 0..1 

//slice the identifier
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd

* identifier contains 

    dormant 0..* MS

* identifier[dormant].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[dormant].use = #old

* alias.extension contains 
    organization-aliasType 0..1
*/