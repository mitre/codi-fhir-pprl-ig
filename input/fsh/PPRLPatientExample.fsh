Instance: PPRLPatientExample
InstanceOf: PPRLPatient
Title: "Example of a PPRL Patient"
Usage: #example
* gender = #male
* identifier[0].system = "https://pcornet.org/cdm/demographic/patid"
* identifier[0].value = "12345"
* name.given = "John"
* name.family = "Doe"
* extension[us-core-birthsex].valueCode = #M
* address.line = "202 Burlington Rd."
* address.city = "Bedford"
* address.postalCode = "01730"
* address.state = "MA"
* birthDate = 1960-04-25
