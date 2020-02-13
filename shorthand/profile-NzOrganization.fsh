

Profile:        NzOrganization
Parent:         Organization
Id:             NzOrganization
Title:          "NZ Organization"
Description:    "NZ Organizations"


* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>NZ Organization  profile</div>"
* ^text.status = #additional

//slice the identifier
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    orgId 0..* MS
* identifier[orgId].system = "https://standards.digital.health.nz/id/hpi-org"
* identifier[orgId].use = #official


/*

//=======================



Profile:        HpiOrganization
Parent:         NzOrganization
Id:             HpiOrganization
Title:          "HPI Organization"
Description:    "Organizations used by the HPI."

* ^purpose = "Describe the Organization that will be returned by the HPI"
* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>HPI Organization  profile</div>"
* ^text.status = #additional

//elements that have been removed
* address 0..0
* contact 0..0

//top level  extensions
* extension contains 
    organization-period 0..1  
    

//slice the identifier
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd
* identifier contains 
    dormant 0..* MS


* identifier[dormant].system = "https://standards.digital.health.nz/id/hpi-org"
* identifier[dormant].use = #old

//add an extension to alias
* alias.extension contains
    organization-aliasType 0..1

    */