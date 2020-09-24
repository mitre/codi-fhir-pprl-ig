Profile: PPRLPatient
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
Id: pprl-patient
Title: "PPRL Patient"
Description: "A patient with the requirements for Privacy Preserving Record Linkage (PPRL)."

* birthDate 1..1	// Makes birthdate mandatory
* extension[birthsex] 1..1	// Makes birthsex mandatory
* identifier.id 1..1 // identifier is already [1..*]
* id 1..1	// makes the patient id mandatory
* name.given 1..* // name is already [1..1]
* name.family 1..1 // name is already [1..1]
//* name.middle 0..1 // Not within HumanName, also not everyone has middle name? Maybe need to make a new PPRLHumanName to have a middle?
* extension contains
	insuranceNumber 1..1 // PROBABLY WRONG, not within USCorePatient. Also this doesn't specify that it should be a string/valuetype (not sure how to do so).
* contact 1..* // Makes the contact field mandatory
* contact.name 1..1 // Makes the contact name mandatory
* contact.name.given 1..1
* contact.name.family 1..1
* address 1..* // makes an address mandatory
* address.line 1..1
* address.postalCode 1..1
* telecom 2..* // Where one entry must be the phone number, and one must be the email
//* telecom[0].system = #phone
//* telecom[1].system = #email
* link 1..1	// Makes the link and link ID mandatory (Which is the whole point of PPRL)
* link.id 1..1

// ---NOTES:
// Overall, we are able to use USCorePatient and just change the vast majority of the cardinalities from 0..x to 1..x.
// Possible some issues with how I changed cardinalities within fields of "HumanName". Do I need to make a PPRLHumanName? Same with "Address" -> PPRLAddress?
// Not sure that my implementation of insuranceNumber is correct, especially since it doesn't specify a type.
// In USCore, it says given name includes middle names, so am I good to leave out the middle initial field from the identifier table?
// telecom has some weird stuff with specifying that at least 1 phone number and 1 email are present.
// After running the validator on this, it passes (except that the URL does not resolve since its a made up pprl one I put in temporarily)

/*
 ---A CODI Patient that meets the PPRL Requirements must have the following attributes:
 1) Birthdate	(within USCorePatient as birthDate [0..1])
 2) Gender	(Within USCorePatient as "birthsex" with cardinality [0..1], also as "gender" with cardinality [1..1])
 3) IDENTIFIERID	(Within USCorePatient as "identifier.id" with cardinality [0..1])
 4) PATID	(Within USCorePatient as "id" with cardinality [0..1])
 5) GIVEN_NAME (Within USCorePatient as "name.given" with cardinality [0..*] gonna need to redefine HumanName with new cardinalities)
 6) PARENT_FAMILY_NAME 	(Within USCorePatient as "name.family" with cardinality [0..1])
 7) MIDDLE_INITIAL	(Not within USCorePatient, will add to PPRLHumanName with cardinality [0..1]?)
 8) INSURANCE_NUMBER	(Not within USCorePatient)
 9) PARENT_GIVEN_NAME	(Within USCorePatient as "contact.name.family" with cardinality [0..1])
 10) PARENT_FAMILY_NAME	(Within USCorePatient as "contact.name.given" with cardinality [0..1])
 11) HOUSEHOLD_STREET_ADDRESS (Within USCorePatient as "address.line" with cardinality [0..1], will need to create a new PPRLAddress)
 12) HOUSEHOLD_ZIP (Within USCorePatient as "address.postalcode" with cardinality [0..1], will need to create a new PPRLAddress)
 13) HOUSEHOLD_PHONE (telecom[0])
 15) HOUSEHOLD_EMAIL (telecom[1])
 16) Link ID should also be mandatory since that's the whole point of PPRL
*/