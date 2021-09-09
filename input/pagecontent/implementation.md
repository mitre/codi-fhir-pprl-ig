### Implementation and Conformance Requirements
This page contains the implementation requirements for PPRL.

#### Patient Resource
The Patient Information System FHIR Server's Patient resources MUST provide the following attributes:

* birthDate
* birthSex
* identifier
* name.given
* name.family
* contact.name.given
* contact.name.family
* address.line
* address.postalCode
* telecom[phoneNumber]
* telecom[email]
* The required patient attributes can also be seen in the [PPRLPatient Structure Definition](StructureDefinition-pprl-patient.html)

#### Bulk FHIR
The Patient Information System FHIR Server MUST implement a FHIR Bulk Data Exporter that exports all patients desired to be included in the PPRL process. It should export the patients in the NDJSON format prescribed by [FHIR Bulk Data Export Requirements](https://hl7.org/fhir/uv/bulkdata/).

### Mapping to the CODI Data Model
For users of the CODI Data Model, the PPRL Patient Profile corresponds to the CODI `IDENTIFIER` table. The following mappings apply.

| **CODI Table** | **CODI Data Element** | **FHIR Data Element** | **FHIR Resource/Profile/Extension** | **Comments** |
| -- | -- | -- | -- | -- |
| IDENTIFIER | GIVEN_NAME | name.given | PPRLPatient | |
| IDENTIFIER | FAMILY_NAME | name.family | PPRLPatient | |
| IDENTIFIER | PARENT_GIVEN_NAME | contact.name.given | PPRLPatient | Optional |
| IDENTIFIER | PARENT_FAMILY_NAME | contact.name.family | PPRLPatient | Optional |
| IDENTIFIER | HOUSEHOLD_STREET_ADDRESS | address.line | PPRLPatient | |
| IDENTIFIER | HOUSEHOLD_ZIP | address.postalCode | PPRLPatient | |
| IDENTIFIER | HOUSEHOLD_PHONE | telecom[phoneNumber] | PPRLPatient | Optional |
| IDENTIFIER | HOUSEHOLD_EMAIL | telecom[email] | PPRLPatient | Optional |
| IDENTIFIER | BIRTH_DATE | birthDate | PPRLPatient | |
| IDENTIFIER | SEX | birthSex | PPRLPatient | |
| IDENTIFIER | PATID | identifier | PPRLPatient | |
