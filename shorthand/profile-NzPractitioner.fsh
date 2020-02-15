
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
* name 1..* MS
* name.family 1..1 MS

//slice identifier to add the NHI as Must Support
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.description = "The identifiers"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    HPI 0..1 MS 

* identifier[HPI].system = "https://standards.digital.health.nz/id/hpi-person"
* identifier[HPI].use = #official
* identifier[HPI] ^short = "The currently active CPN (Common Person Name)"