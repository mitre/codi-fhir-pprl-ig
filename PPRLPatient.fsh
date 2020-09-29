Profile: PPRLPatient
Parent: http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient
Id: pprl-patient
Title: "PPRL Patient"
Description: "A patient with the requirements for Privacy Preserving Record Linkage (PPRL)."

* birthDate 1..1				// Makes birthdate mandatory
* extension[birthsex] 1..1		// Makes birthsex mandatory
* identifier.id 1..1			// identifier is already [1..*]
* id 1..1						// makes the patient id mandatory
* name.given 1..* 				// name is already [1..*]
* name.family 1..1
* contact 1..* 					// Makes the contact field mandatory
* contact.name 1..1 			// Makes the contact name mandatory
* contact.name.given 1..*
* contact.name.family 1..1
* address 1..* 					// Makes an address mandatory
* address.line 1..1
* address.postalCode 1..1
* telecom 1..* 					// Where one entry must be the phone number, and one must be the email
* telecom ^slicing.discriminator.type = #pattern
* telecom ^slicing.discriminator.path = "system"
* telecom ^slicing.rules = #open
* telecom contains phoneNumber 1..* and emailAddress 1..*
* telecom[phoneNumber].system = #phone 
* telecom[emailAddress].system = #email
* link 0..1
* link.id 1..1

/*
 	---First Pass Notes:
 Overall, we are able to use USCorePatient and just change the vast majority of the cardinalities from 0..x to 1..x.
 Possible some issues with how I changed cardinalities within fields of "HumanName". Do I need to make a PPRLHumanName? Same with "Address" -> PPRLAddress?
 Not sure that my implementation of insuranceNumber is correct, especially since it doesn't specify a type.
 In USCore, it says given name includes middle names, so am I good to leave out the middle initial field from the identifier table?
 telecom has some weird stuff with specifying that at least 1 phone number and 1 email are present.
 After running the validator on this, it passes (except that the URL does not resolve since its a made up pprl one I put in temporarily)
*/

/*
 	---A Patient that meets the PPRL Requirements must have the following attributes:
 1) Birthdate		(within USCorePatient as birthDate [0..1])
 2) Gender			(Within USCorePatient as "birthsex" with cardinality [0..1], also as "gender" with cardinality [1..1])
 3) IDENTIFIERID	(Within USCorePatient as "identifier.id" with cardinality [0..1])
 4) PATID			(Within USCorePatient as "id" with cardinality [0..1])
 5) PARENT_GIVEN_NAME	(Within USCorePatient as "name.given" with cardinality [0..*])
 6) PARENT_FAMILY_NAME 	(Within USCorePatient as "name.family" with cardinality [0..1])
 7) MIDDLE_INITIAL	(Not within USCorePatient, but is implied in givenName)
 8) INSURANCE_NUMBER	(REMOVED) (Not within USCorePatient, we have removed this requirement)
 9) PARENT_GIVEN_NAME	(Within USCorePatient as "contact.name.family" with cardinality [0..1])
 10) PARENT_FAMILY_NAME	(Within USCorePatient as "contact.name.given" with cardinality [0..1])
 11) HOUSEHOLD_STREET_ADDRESS	(Within USCorePatient as "address.line" with cardinality [0..1])
 12) HOUSEHOLD_ZIP	(Within USCorePatient as "address.postalcode" with cardinality [0..1])
 13) HOUSEHOLD_PHONE	(Within USCorePatient as "telecom.*")
 15) HOUSEHOLD_EMAIL	(Within USCorePatient as "telecom.*")
 16) LINK.ID 		(Not within USCorePatient and cannot be mandatory since the patient won't initially have one until after PPRL runs)
*/