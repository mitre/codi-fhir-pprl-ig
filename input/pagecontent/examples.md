### Resource Examples

This section provides some examples how different resources may be represented in a FHIR instance which conforms to this implementation guide.

#### Patient Related Examples

* [PPRL Patient Example](Patient-PPRLPatientExample.html) includes only the required attributes of a PPRLPatient profile.
* [Matching PPRL Patient Example](Patient-12345.html) shows what a Record Linkage System or PPRL Client should return, in a Bundle, to a Data Owner to incorporate in their Patient Information System. Also, see the Matching Bundle for the structure that will incorporate a collection of these.

#### Matching Bundle Example
* [Matching Bundle Example](Bundle-MatchingBundleExample.html) shows the full Bundle that a Record Linkage System or PPRL Client should return to a Data Owner. Will contain multiple Matching PPRL Patient resources.