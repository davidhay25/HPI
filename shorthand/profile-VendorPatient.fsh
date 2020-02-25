
Profile:        VendorPatient
Parent:         NzPatient
Id:             VendorPatient
Title:          "Vendor Patient"
Description:    "An example of a Patient resource further specialized by a Vendor."

* ^text.div = "<div xmlns='http://www.w3.org/1999/xhtml'>Vendor Patient profile</div>"
* ^text.status = #additional

//elements that have been removed
* active 0..0
* photo 0..0

// - This vendor does support contact
* communication 0..0
* managingOrganization 0..0
* link 0..0

//root level extensions
* extension contains
    EyeColour 0..1

//Limit the possible resources for generalPractitioner only to a Practitioner
//Note that this might still be a contained resource - that's still supported by this profile
* generalPractitioner only Reference(Practitioner)

//define the extension in-line for the purposeson demonstration. (it won't appear in the extensions lists though...)
Extension: EyeColour
Id: EyeColour
Description: "The patients eye coulor. A simple string."

* extension 0..0
* value[x] only string
