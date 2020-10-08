<div xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://hl7.org/fhir ../../input-cache/schemas-r5/fhir-single.xsd">


<ul>
    <li><a href="#Background">Background</a></li>
    <li><a href="#Process">Process</a></li>
    <li><a href="#BulkData">FHIR Bulk Data</a></li>
    <li><a href="#Disclaimers">Disclaimers and Known Limitations</a></li>
    <li><a href="#Contacts">Contact Information</a></li>
    <li><a href="#Credits">Credits</a></li>
</ul>

<h3><a name="Background">Background</a></h3>
<p>Patient Privacy Record Linkage (PPRL) is a process in which multiple patient records are linked without compromising or exposing their privacy or identities.</p>

<p>To perform population health analyses, the Centers for Disease Control (CDC) uses data from many health organizations around the country. However, in the interest of preserving patient privacy, health organizations and hospitals will provide de-identified data, so that no one person can be linked to any health data. This presents the problem of linking multiple data records for the same patient: if a patient recieves care at multiple hospitals, each of their records at each hospital will be treated independently, creating multiple incomplete health records. PPRL aims to solve this issue without compromising Personally Identifiable Information (PII) or privacy by conducting record linkages between patient records without any PII data leaving the boundaries of a hospital. This allows the CDC to more accurately assess population health by providing complete health histories for individual patients without compromising their privacies or identities.</p>

<p>During the PPRL process, PII is obfuscated, or hashed in a series of prescribed steps prior to transmission beyond an organizational boundary for matching. The process of hashing results in data that is nearly impossible for an outside party to recover PII from, but still allows for the establishment of record linkages across organizations. PPRL also allows for “blind” matching in which a third party, known as a linkage agent, is provided access to the hashed data, but is unable to view PII. The linkage agent then compares the obfuscated information to establish linkages between a patient's multiple records with a unique Link Identifier. The following figure illustrates this process.</p>

<img src="pprl-blind-matching.png" alt="PPRL Blind Matching" width="100%" align="left" style="margin: 0px 250px 0px 0px;" />

<p>This Implementation Guide serves the pupose of defining the requirements that patient data stored by Data Owners must meet for PPRL. A Data Owner's patients must conform to the PPRLPatient Profile for the PPRL process to work correctly so that record linkages can be conducted consistently and corectly. The Implementation Guide is also planned to include the requirements for FHIR Bulk Data export, enforcing the requirement that a Data Owner be able to bulk export all patients in the NDJSON format.</p>

<p>The PPRLPatient requirements are derived from USCore except that certain identifying information is now required instead of optional. Visit the <a href="StructureDefinition-pprl-patient.html">PPRLPatient Structure Definition</a> Differential Table to see which attributes are newly required. You may also visit the <a href="implementation.html">Implementation and Conformance Requirements</a>.</p>

<h3><a name="Process">Process</a></h3>
<h4><a name="Roles">The PPRL Process depends on the interactions of the following 3 actors:</a></h4>
<ul>
    <li><b>Key Escrow</b>: Contains the Patient Record Keys
    <ul><li>Shares the configuration files used in encryption and the encryption key with Data Owners.</li></ul></li>
    <li><b>Data Owner</b>: Owns the Data to be PPRL'd
    <ul><li>Will conduct the hashing of the data and share it for record linkage. Will incorporate the record linkage unique identifiers into their system.</li></ul></li>
    <li><b>Linkage Agent</b>: Performs Record Linkage
    <ul><li>Uses the encrypted hashed data from the Data Owners to perform record linkage, providing Data Owners with the unique identifiers from the PPRL process. This role can be performed by any trusted organization, whether that be the CDC or some third party.</li></ul></li>
</ul>

<p>The PPRL Process involves the following sequence of steps:</p>
<ol>
    <il>A key escrow shares configuration information with each data partner. This includes information required to use the linkage method and the encryption key that is used by all the data partners.</il>
    <il>Each data partner creates a hashed dataset by:
    <ul>
        <li>Extracting PII from its operational database. These data elements must meet agreed-upon specifications, the choice of PII attributes may depend on characteristics of the data population and will affect the level of linkage accuracy attainable.</li>
        <li>Using the encryption keys provided by the key escrow to pass the PII through a hashing process that will obfuscate the information.</li>
        <li>Sharing the hashed data with the linkage agent.</li>
    </ul></il>
    <il>The linkage agent develops a unique identifier known as a LINKID by:
    <ul>
        <li>Determining which hashed values correspond to the same individual.</li>
        <li>Establishing a unique LINKID for each individual.</li>
    </ul></il>
    <il>The linkage agent shares the LINKIDs with each data partner. The LINKIDs can be stored by the data partners for future queries, provided the data holdings of the data partners remain constant. The Linkage Agent can then match records for the same patients accross health systems.</il>
</ol>

<p>The PPRL Process follows the flow in this Swim Lane Diagram. It details the three actors and their chronological interactions throughout the PPRL Process.</p>

<img src="pprl-process.png" alt="PPRL Process and Workflow" width="80%" align="left" style="margin: 0px 250px 0px 0px;" />

<h4><a name="Salting">Salting</a></h4>
<p>The Salting Process creates a "salt" which is a random hash that encypts data to safegaurd and privatize it. It is handled by the Key Escrow.</p>
<ul>
    <li>Data Owner generates salt (tested and ready)</li>
    <li>Data Owner sends salt value via secure email (tested and ready)</li>
    <li>Data Owner destroys salt (not on critical path for testing)</li>
    <p>The Data Owner must Destroy Salt value when hashing is complete, which serves the pupose of ___.</p>
</ul>

<h4><a name="ExtractAndGarble">Extract and Garble</a></h4>
<p>Extracting and Garbling is handled by the Data Owner.</p>
<ul>
    <li>Data Owner must have an identifier table that data can be pulled from.</li>
    <li>Data Owner must garble the data.</li>
    <li>Data Owner will send the garbled infomation to the Linkage Agent using Secure File Transfer Protocol (SFTP).</li>
    <li>Linkage Agent will distribute credentials to Data Owners..</li>
</ul>

<h4><a name="PerformLinkage">Perform Linkage</a></h4>
<p>The patient record linkage is handled by the Linkage Agent.</p>
<ul>
    <li>The Linkage Agent will run the linkage sofware based on the garbled information given by the Data Owner.</li>
    <li>The Linkage Agent will run a script to generate seperate LINKID files for Data Owners.</li>
    <li>Data Owners will translate the LINKIDs into PATIDs and insert this inforamtion into the LINK table.</li>
</ul>

<h3><a name="BulkData">FHIR Bulk Data</a></h3>
<p>FHIR Bulk Patient Data Requirements.</p>
<ul>
    <li>PPRL requires that the Data Owner have an implementation of <a href="https://hl7.org/fhir/uv/bulkdata/" target="_blank">FHIR Bulk Data Export</a> so that mass patients may be exported and PPRL'd.</li>
</ul>

<h3><a name="Disclaimers">Disclaimers and Known Limitations</a></h3>
<p>PPRL is intended to preserve the privacy of PII while enabling matching. However, like other record matching techniques, the PPRL process has several weaknesses that can impact the security and privacy of PII: (1) the PPRL process is vulnerable to adversary attacks resulting in breaches in privacy, (2) poor data quality and errors in matching can degrade linkage quality, and (3) there are computational limitations to scale the PPRL process.</p>

<h3><a name="Credits">Credits</a></h3>
<p>Authored by the CODI project at MITRE, sponsored by the CDC </p>
<p>This IG was authored by the MITRE Corporation using <a href="http://build.fhir.org/ig/HL7/fhir-shorthand/" target="_blank">FHIR Shorthand (FSH)</a> and <a href="https://github.com/FHIR/sushi" target="_blank">SUSHI</a>, a free, open source toolchain from the <a href="https://www.mitre.org/" target="_blank">MITRE Corporation</a>.</p>

<h3><a name="Contacts">Contact Information</a></h3>
<table width="100%">
    <tbody>
    <tr>
    <td width="20%">
    <p>General Inquiries:</p>
    </td>
    <td width="80%">
    <p><a href="mailto:rscalfani@mitre.org">rscalfani@mitre.org</a></p>
    <p><a href="mailto:andrewg@mitre.org">andrewg@mitre.org</a></p>
    </td>
    </tr>
    <tr>
    <td width="20%">
    <p>Co-Editor:</p>
    </td>
    <td width="80%">
    <p>Andrew Gregorowicz</p>
    <p>MITRE Corporation</p>
    <p><a href="mailto:andrewg@mitre.org">andrewg@mitre.org</a></p>
    </td>
    </tr>
    <tr>
    <td width="20%">
    <p>Co-Editor:</p>
    </td>
    <td width="80%">
    <p>Robert Scalfani</p>
    <p>MITRE Corporation</p>
    <p><a href="mailto:rscalfani@mitre.org">rscalfani@mitre.org</a></p>
    </td>
    </tr>
    </tbody>
    </table>
    
<p>PPRL was developed by the MITRE Corporation under the CODI Initiative sponsored by the CDC.</p>
<ul>
    <li><a href="mitre.org" target="_blank">MITRE Website</a></li>
</ul>

MITRE: NOT Approved for Public Release. Distribution Unlimited. Case Number XXX

</div>
