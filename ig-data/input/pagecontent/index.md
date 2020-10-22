* <a href="#Background">Background</a>
* <a href="#Roles">Roles</a>
* <a href="#BulkData">FHIR Bulk Data</a>
* <a href="#Disclaimers">Disclaimers and Known Limitations</a>
* <a href="#Contacts">Contact Information</a>
* <a href="#Credits">Credits</a>


### <a name="Background">Background</a>
Privacy Preserving Record Linkage (PPRL) is a process in which multiple records for a single patient are linked without compromising or exposing their privacy or identities.

To perform population health analyses, researchers may want access to data across multiple organizations. However, this presents the problem of having multiple data records for the same patient: if a patient recieves care at multiple healthcare providers, each of their records at each provider will be treated independently, creating multiple incomplete health records. PPRL aims to solve this issue without compromising Personally Identifiable Information (PII) or privacy by conducting record linkages between patient records without any PII data leaving the boundaries of a provider. This allows researchers to more accurately assess population health by providing complete health histories for individual patients without compromising their privacies or identities.

During the PPRL process, PII is obfuscated in a series of prescribed steps prior to transmission beyond an organizational boundary for matching. The process of obfuscation results in data that is nearly impossible for an outside party to recover PII from, but still allows for the establishment of record linkages across organizations. PPRL allows for “blind” matching in which a third party, the Linkage Agent, is provided access to the obfuscated data, but is unable to view PII. The Linkage Agent then compares the obfuscated information to establish linkages between a patient's multiple records with a unique Link Identifier. The following figure illustrates this process.

<img src="pprl-blind-matching.png" alt="PPRL Blind Matching" width="100%" align="left" style="margin: 0px 250px 0px 0px;" />

This Implementation Guide serves the pupose of defining the requirements that patient data stored by Data Owners must meet for PPRL. A Data Owner's patients must conform to the PPRLPatient Profile for the PPRL process to work correctly so that record linkages can be conducted consistently and correctly. This is because PPRL depends on the demographic attributes of a patient, which must be consistent accross organizations for the same patient. The Implementation Guide is also planned to include the requirements for FHIR Bulk Data export, enforcing the requirement that a Data Owner be able to bulk export all patients in the NDJSON format.

The PPRLPatient requirements are derived from USCore except that certain identifying information and attributes are now required instead of optional. Visit the [PPRLPatient Structure Definition](StructureDefinition-pprl-patient.html) Differential Table to see which attributes are required. You may also visit the [Implementation and Conformance Requirements](implementation.html).

### <a name="Roles">Roles</a>
**The PPRL Process depends on the interactions of the following 3 actors:**

* **Key Escrow**: Responsible for maintaining and distributing secret values needed to support the PPRL Process.
  * The Key Escrow may also manage configuration information for the PPRL process. The specific details about PPRL tool configuration and distribution are vendor specific and out of scope for this IG.
* **Data Owner**: Onganizations who have custody of PII that will be used for the PPRL process.
  * Will conduct the obfuscation of the data and share it for record linkage. Will incorporate the record linkage unique identifiers into their system.
* **Linkage Agent**: Performs Record Linkage
  * Uses the obfuscated data from the Data Owners to perform record linkage, providing Data Owners with the unique identifiers from the PPRL process.

#### The PPRL Process follows this sequence of steps:

1.  Each Data Partner creates their obfuscated patient dataset by:
    * Extracting PII from its operational database. These data elements must meet agreed-upon specifications; the choice of PII attributes may depend on characteristics of the data population and will effect the accuracy of record linkage.
    * Using the encryption keys provided by the Key Escrow to pass the PII through a consistent process that will obfuscate the information.
    * Sharing the obfuscated data with the Linkage Agent.
1. The Linkage Agent develops a unique identifier for each patient record known as a LINKID by:
    * Determining which obfuscated values correspond to the same individual.
    * Establishing a unique LINKID for each individual.
1.  The linkage agent shares the LINKIDs with each Data Partner. The LINKIDs can be stored by the data partners for future queries, provided the data holdings of the data partners remain constant. The Linkage Agent can then match records for the same patients accross multiple additional health systems.

The PPRL Process follows the flow in this Swim Lane Diagram. It details the three actors and their chronological interactions throughout the PPRL Process.

<img src="pprl-process.png" alt="PPRL Process and Workflow" width="80%" align="left" style="margin: 0px 250px 0px 0px;" />

#### Extract
Data owners provide their data via Bulk FHIR

#### Obfuscation
Obfuscation processes the PII such that it is de-identified, but can still be used for linkage purposes. This may involve the use of hashing algorithms or the construction of Bloom filters. The exact details of the obfuscation set are dependent on the PPLR tool being used and are out of scope for this IG. The method and its encryption key is given by the Key Escrow to each of the Data Owners to ensure consistent processing. It follows the sequence of steps:

* Data Owner must have a patient PII data table that data can be extraced from.
* Data Owner obfuscates its patient PII data using the given method and pepper.
* Data Owner sends obfuscated data to the Linkage Agent.
* Data Owner destroys pepper and notifies others that it has been destroyed to maintain the security of the process.

#### Perform Linkage

Patient record linkage is handled by the Linkage Agent.

* The Linkage Agent runs the linkage sofware on the garbled patient data given by the Data Owners.
* The Linkage Agent runs a script to generate seperate LINKID files for the patient data to be distributed to the Data Owners.

### <a name="BulkData">FHIR Bulk Data</a>

FHIR Bulk Patient Data Requirements.

* PPRL requires that the Data Owner have an implementation of [FHIR Bulk Data Export](https://hl7.org/fhir/uv/bulkdata/) so that mass patients may be exported and PPRL'd.
* The FHIR Bulk Data implementation should export in NDJSON format in which each patient makes up a single line in the file. The patients in each line should be in valid JSON format but are seperated from eachother by newlines.

### <a name="Disclaimers">Disclaimers and Known Limitations</a>
PPRL is intended to preserve the privacy of PII while enabling matching. However, like other record matching techniques, the PPRL process has several weaknesses that can impact the security and privacy of PII: (1) the PPRL process is vulnerable to adversary attacks resulting in breaches in privacy, (2) poor data quality and errors in matching can degrade linkage quality, and (3) there are computational limitations to scale the PPRL process.</p>

### <a name="Credits">Credits</a>
Authored by the CODI project at MITRE, sponsored by the CDC.

This IG was authored by the MITRE Corporation using [FHIR Shorthand (FSH)](http://build.fhir.org/ig/HL7/fhir-shorthand/) and [SUSHI](https://github.com/FHIR/sushi), a free, open source toolchain from the [MITRE Corporation](https://www.mitre.org/).

### <a name="Contacts">Contact Information</a>

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

MITRE: NOT Approved for Public Release. Distribution Unlimited. Case Number XXX

