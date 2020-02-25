

Profile:        NzOrganization
Parent:         Organization
Id:             NzOrganization
Title:          "NZ Organization"
Description:    "NZ Organizations"


* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>NZ base Organization  profile</div>"
* ^text.status = #additional

//slice the identifier for HPI Organization identifierr
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    orgId 0..* MS
* identifier[orgId].system = "https://standards.digital.health.nz/id/hpi-org"
* identifier[orgId].use = #official


