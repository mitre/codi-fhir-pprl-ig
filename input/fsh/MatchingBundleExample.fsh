Instance: MatchingBundleExample
InstanceOf: MatchingBundle
Title: "Example Bundle providing the results of a PPRL match"
Usage: #example
* type = http://hl7.org/fhir/bundle-type#transaction
* entry.request.method = http://hl7.org/fhir/http-verb#PUT
* entry.request.url = "/Patient/12345"
* entry.resource = MatchedPPRLPatientExample