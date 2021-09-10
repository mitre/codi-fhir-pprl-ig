Instance: MatchedPPRLPatientExample
InstanceOf: PPRLPatient
Title: "Example of a match result with an additional identifier"
Usage: #example
* id = "12345"
* gender = #male
* identifier[0].system = "https://pcornet.org/cdm/demographic/patid"
* identifier[0].value = "12345"
* identifier[1].system = "https://example-linkage-agent.org/linkage-id"
* identifier[1].value = "LN556723-01"
* name.given = "John"
* name.family = "Doe"
* extension[us-core-birthsex].valueCode = #M
* address.line = "202 Burlington Rd."
* address.city = "Bedford"
* address.postalCode = "01730"
* address.state = "MA"
* birthDate = 1960-04-25
* telecom[0].system = #phone
* telecom[0].value = "555-867-5309"
* telecom[1].system = #email
* telecom[1].value = "john.doe@example.com"

