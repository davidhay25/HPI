Profile:        NhiPatient
Parent:         Patient
Id:             NhiPatient
Title:          "NHI Patient"
Description:    "The Patient resource exposed by the NHI."

* ^purpose = "Describe the Patient resource exposed by the NHI"
* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>NHI Patient profile</div>"
* ^text.status = #additional

//elements that have been removed
* active 0..0
* photo 0..0
* contact 0..0
* communication 0..0
* managingOrganization 0..0
* link 0..0

//root level extensions
* extension contains
    ethnicity 0..4 and
    patient-birthPlace 0..1 and
    patient-citizenship 0..1 and
    dhb 0..1 and
    patient-iwi 0..1 and
    patient-maoriDescent 0..1

//identifier - current and dormant
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd

* identifier contains 
    NHI 0..1 MS and 
    dormant 0..* MS
* identifier[NHI].system = "https://standards.digital.health.nz/id/nhi"
* identifier[NHI].use = #official
* identifier[dormant].system = "https://standards.digital.health.nz/id/nhi"
* identifier[dormant].use = #old

//Name is required, and there are extensions for source, and isPreferred
* name 1..1
* name.extension contains
    informationsource  0..1 and
    iso21090-preferred 1..1

//The gender has an extension for the original text that was used to establish it (eg from a form)
* gender.extension contains 
    originalValue 0..1

//birthdate is required, and has an extension for source 
* birthDate 1..1
* birthDate.extension contains  
    informationsource  0..1 

//date of death has an extension for source
* deceasedDateTime.extension contains   
    informationsource  0..1

// address is required and has a number of extensions
* address 1..*
* address.line 1..*     //there will always be at least 1 line
* address.extension contains
    buildingName 0..1 and   //the name of the building - as it is known locally
    nzGeocode 0..1 and      //New Zealand geocode (Uses a NZ specific datum )
    patient-addressDerived 0..1     //a set of data derived from the address

//Limit the possible resources for generalPractitioner only to a PractitionerRole
//Note that this might still be a contained resource - that's still supported by this profile
* generalPractitioner only Reference(PractitionerRole)