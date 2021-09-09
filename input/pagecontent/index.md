### Background
Privacy Preserving Record Linkage (PPRL) is a process in which multiple records for a single patient are linked without compromising or exposing their privacy or identities.

To perform population health analyses, researchers may want access to data across multiple organizations. However, this presents the problem of having multiple data records for the same patient. If a patient recieves care at multiple healthcare providers, each of their records at each provider will be treated independently, creating multiple incomplete health records. PPRL aims to solve this issue without compromising Personally Identifiable Information (PII) or privacy by conducting record linkages between patient records without any PII data leaving the boundaries of a provider. This allows researchers to more accurately assess population health by providing complete health histories for individual patients without compromising their privacies or identities.

During the PPRL process, PII is obfuscated in a series of prescribed steps prior to transmission beyond an organizational boundary for matching. Organizations with records to be linked as a apart of the PPRL process are referred to as Data Owners. The process of obfuscation results in data that is nearly impossible for an outside party to recover PII from, but still allows for the establishment of record linkages across organizations. PPRL allows for “blind” matching in which a third party, the Linkage Agent, is provided access to the obfuscated data, but is unable to view PII. The Linkage Agent then compares the obfuscated information to establish linkages between a patient's multiple records with a unique Link Identifier. The following figure illustrates this process.

<img src="pprl-blind-matching.png" alt="PPRL Blind Matching" width="100%" align="left" style="margin: 0px 250px 0px 0px;" />

This Implementation Guide specifies how a PPRL process can be conducted when Data Owners retain patient information in FHIR enabled systems. It specifies the processes for

This Implementation Guide serves the pupose of defining the requirements that patient data stored by Data Owners must meet for PPRL.

The PPRLPatient requirements are derived from USCore except that certain identifying information and attributes are now required instead of optional. Visit the [PPRLPatient Structure Definition](StructureDefinition-pprl-patient.html) Differential Table to see which attributes are required. You may also visit the [Implementation and Conformance Requirements](implementation.html).

### Roles and Systems
#### Roles
**The PPRL Process depends on the interactions of the following 3 actors:**

* **Key Escrow**: Responsible for maintaining and distributing peppers needed to support the PPRL Process.
  * The Key Escrow may also manage configuration information for the PPRL process. The specific details about PPRL tool configuration and distribution are vendor specific and out of scope for this IG.
* **Data Owner**: Onganizations who have custody of PII that will be used for the PPRL process.
  * Will conduct the obfuscation of the data and share it for record linkage. Will incorporate the record linkage unique identifiers into their system.
* **Linkage Agent**: Performs Record Linkage
  * Uses the obfuscated data from the Data Owners to perform record linkage, providing Data Owners with the unique identifiers from the PPRL process.

#### Systems
**The following systems are involved in the execution of the PPRL Process:**

* **Secret Generator**: A system residing at the Key Escrow responsible for generating a pepper for the PPRL Process.
* **Patient Information System**: The system at a Data Owner that contains PII and related information on individuals to be linked. This may be an Electronic Health Record (EHR) system.
* **PPRL Client**: Software that operates at the Data Owner to facilitate obfuscation of PII. This software may also be responsible for processing responses from the Record Linking System.
* **Record Linking System**: The system that performs record linkage on obfuscated information.

#### Overall PPRL Solution

The following image shows how the roles and systems interact to create an overall PPRL Solution.

<img src="fhir-pprl-system.png" alt="Systems involved in PPRL" width="100%" align="left" style="margin: 0px 250px 0px 0px;" />

### The PPRL Process

The PPRL Process requires the following steps:

1. The Key Escrow, using the Secret Generator, generates a pepper, often referred to as a [salt](https://auth0.com/blog/adding-salt-to-hashing-a-better-way-to-store-passwords/), but technically a [pepper](https://simplicable.com/new/salt-vs-pepper), for use for a particular record linkage cycle. Throughout the rest of this implementation guide, the term pepper will be used.
1. The pepper is securely transmitted from the Key Escrow to all Data Owners participating in the PPRL process.
1. Each Data Owner will use the PPRL Client to extract information from their Patient Information System. Using the extracted information and pepper, the PPRL Client will obfuscate the information.
1. Each Data Owner will transmit the obfuscated information to the Linkage Agent.
1. The Linkage Agent will use the Record Linking System to identify matches from the obfuscated data. The Record Linking System will assign identifiers to individuals based on the matching process.
1. The Linkage Agent will communicate the identifiers to the Data Owners
1. The Data Owners will associate the identifiers with the individuals in the Patient Information System. The PPRL Client may be used to facilitate this process.

The steps of this process are shown below:

<img src="fhir-pprl-process.png" alt="PPRL sequence diagram" width="100%" align="left" style="margin: 0px 250px 0px 0px;" />

#### Pepper Generation
The key escrow is the organization responsible for creating the pepper or encryption key that data owners and data providers will use in the de-identification process. Given that the de-identification process relies on the pepper remaining secure, it is critical that it be created and distributed appropriately.

The exact mechanism for generation of the pepper value is not specified by this implementation guide. The most important aspect of the pepper is that it is sufficiently random to prevent re-identification through brute force compytation. As such, the key escrow must use a Cryptographically Secure Pseudo-Random Number Generator (CSPRNG) as the source for the salt value. The Open Web Application Security Project provides a [Cryptographic Storage Cheat Sheet](https://github.com/OWASP/CheatSheetSeries/blob/master/cheatsheets/Cryptographic_Storage_Cheat_Sheet.md#secure-random-number-generation) with references to appropriate CSPRNGs.

#### Pepper Transmission from Key Escrow to Data Owners
This implementation guide does not specify the storage format or transport mechanism for a pepper value. The Key Escrow should determine a mechanism that can be used for securely transmitting the pepper to Data Owners.

#### PPRL Client Extract of Information From the Patient Information System
Patient Information Systems must support the [FHIR Bulk Data Access IG](https://hl7.org/fhir/uv/bulkdata/). The PPRL Client SHALL invoke the [patient export FHIR Operation](https://hl7.org/fhir/uv/bulkdata/OperationDefinition-patient-export.html#operationdefinition-patient-export) on the [All Patients Endpoint](https://hl7.org/fhir/uv/bulkdata/export/index.html#endpoint---all-patients) of the Patient Information System. The PPRL Client SHALL then use the [Bulk Data Status Request](https://hl7.org/fhir/uv/bulkdata/export/index.html#bulk-data-status-request) and [File Request](https://hl7.org/fhir/uv/bulkdata/export/index.html#file-request) to obtain access to the [Patient](http://www.hl7.org/implement/standards/fhir/patient.html) resources to acess PII necessary for the PPRL process.

#### Obfuscation
The PPRL Client shall process the PII such that it is de-identified, but can still be used for linkage purposes. This may involve the use of hashing algorithms or the construction of Bloom filters. The exact details of the obfuscation or the data elements used are not specified by this IG. Implementers should be familiar with [HIPAA de-identification methods](https://www.hhs.gov/hipaa/for-professionals/privacy/special-topics/de-identification/index.html). The PPRL Client SHALL use the pepper value obtained by from the Key Escrow to facilitate the obfuscation process.

The storage format for the obfuscated data is not specified by this implementation guide. It is assumed that communication between the PPRL Client and Record Linking System may take place through an implementation specific format. It is not expected to have PPRL Clients and Record Linkage Systems from different vendors or open source solutions.

#### Transmission of Obfuscated Information from Data Owner to Linkage Agent
The obfuscated information created by the PPRL Client shall be transmitted to the Linkage Agent for record linking. The method of transport is not specified by this implementation guide. The transport process may be facilitated by the PPRL Client or it may require additional automated or manual interventions to move the information.

#### Perform Linkage

Once all obfuscated information has been received from Data Owners at the Linkage Agent, the Record Linkage System shall process the information to determine matching records. The exact procedures for determining a match are not specified in this implementation guide. The elements used to match, thresholds for matching and other configuration considerations will vary depending on deployment setting.

#### Communicate Linkage Information with Data Owners

The Linkage System will generate matching information to be shared with Data Owners. Match information shall be represented as a [FHIR Bundle](https://www.hl7.org/fhir/bundle.html) that conforms to the Matching Bundle Profile.

### FHIR Bulk Data

FHIR Bulk Patient Data Requirements.

* PPRL requires that the Data Owner have an implementation of [FHIR Bulk Data Export](https://hl7.org/fhir/uv/bulkdata/) so that mass patients may be exported and PPRL'd.
* The FHIR Bulk Data implementation should export in NDJSON format in which each patient makes up a single line in the file. The patients in each line should be in valid JSON format but are seperated from eachother by newlines.

### Known Limitations
PPRL is intended to preserve the privacy of PII while enabling matching. However, like other record matching techniques, the PPRL process has weaknesses that can impact the process.

An ideal PPRL process is constructed to protect the privacy of individuals. This privacy may be compromised through the disclosure of the secret value, or an obfuscation process that does not sufficiently deidentify the source data. Construction of appropriate obfuscation techniques is outside the scope of this IG.

As with any record matching process, poor source data quality will likely degrade linkage quality. Some techniques used to work with identity data, such as files of nicknames or looking for month/day swaps are unavailable using a PPRL process.

PPRL will often require greater computational resources than a plain text record linkage process.

### Credits
Authored by the CODI project at MITRE, sponsored by the CDC.

This IG was authored by the MITRE Corporation using [FHIR Shorthand (FSH)](http://build.fhir.org/ig/HL7/fhir-shorthand/) and [SUSHI](https://github.com/FHIR/sushi), a free, open source toolchain from the [MITRE Corporation](https://www.mitre.org/).

### Contact Information

| Contact | |
|----------|----------|
| General Inquiries: | |
| | rscalfani@mitre.org |
| | andrewg@mitre.org |
| Co-Editor: | Andy Gregorowicz |
| | The MITRE Corporation |
| | andrewg@mitre.org |
| Co-Editor: | Robert Scalfani |
| | The MITRE Corporation |
| | rscalfani@mitre.org |

The PPRL FHIR Implementation Guide was developed by the [MITRE Corporation](http://www.mitre.org) under the Community and Clinical Data Initative (CODI) sponsored by CDC.
