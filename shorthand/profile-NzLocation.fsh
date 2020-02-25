
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
