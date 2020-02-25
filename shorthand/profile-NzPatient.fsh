
Profile:        NzPatient
Parent:         Patient
Id:             NzPatient
Title:          "NZ Patient"
Description:    "The base Patient resource in NZ"

* ^purpose = "Describe the base New Zealand Patient profile"
* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Base Patient profile</div>"
* ^text.status = #additional

//root level extensions
* extension contains
    ethnicity 0..4 and
    patient-birthPlace 0..1 and
    patient-iwi 0..1 

* name 1..1 MS

//identifier - current NHI
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "use"
* identifier ^slicing.rules = #openAtEnd

* identifier contains 
    NHI 0..1 MS 
* identifier[NHI].system = "http://standards.digital.health.nz/id/nhi"
* identifier[NHI].use = #official
