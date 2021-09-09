Profile: PPRLPatient
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
Id: pprl-patient
Title: "PPRL Patient"
Description: "A patient with the requirements for Privacy Preserving Record Linkage (PPRL)."

* birthDate 1..1                   // Makes birthdate mandatory
* extension[us-core-birthsex] 1..1 // Makes birthsex mandatory
* name.given 1..*                  // name is already [1..*]
* name.family 1..1
* address 1..*                     // Makes an address mandatory
* address.line 1..1
* address.postalCode 1..1
