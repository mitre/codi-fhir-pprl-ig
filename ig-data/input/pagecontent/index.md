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

<p>PPRL depends on the interactions of the following 3 actos::</p>
<ul>
    <li><b>Key Escrow; Contains the Patient Record Keys</b>: <a href="LINK</a></li>
    <li><b>Data Owner; Owns the Data to be PPRL'd</b>: <a href="LINK</a></li>
    <li><b>DCC; Data Coordinating Center</b>: <a href="LINK</a></li>
</ul>

<p>PPRL was developed by the MITRE Corporation under the CODI Initiative sponsored by ___.</p>
<ul>
    <li><a href="mitre.org" target="_blank">MITRE Website</a></li>
</ul>

<h3><a name="Process">Process</a></h3>
<p>The PPRL Process can be seen in the following Swim Lane Diagram:</p>

<img src="pprl-process.png" alt="PPRL Process and Workflow" width="80%" align="left" style="margin: 0px 250px 0px 0px;" />

<h4><a name="Salting">Salting</a></h4>
<p>The Salting Process creates a "salt" which is a random hash that encypts data to safegaurd and privatize it. It is handled by the DCC.</p>
<ul>
    <li>DPH generates salt (tested and ready)</li>
    <li>DPH sends salt value via secure email (tested and ready)</li>
    <li>DPH destroys salt (not on critical path for testing)</li>
    <p>The Data Owner must Destroy Salt value when hashing is complete, which serves the pupose of ___ .</p>
</ul>

<h4><a name="ExtractAndGarble">Extract and Garble</a></h4>
<p>Extracting and Garbling is handled by the Data Owner.</p>
<ul>
    <li>Data Owner must have an identifier table that data can be pulled from.</li>
    <li>Data Owner must garble the data.</li>
    <li>Data Owner will send the garbled infomation to the DCC using Secure File Transfer Protocol (SFTP).</li>
    <li>DCC will be ablke to distribute credentials to Data Owners..</li>
</ul>

<h4><a name="PerformLinkage">Perform Linkage</a></h4>
<p>The patient record linkage is handled by the DCC..</p>
<ul>
    <li>DCC will run the linkage sofware based on the garbled information given by the Data Owner.</li>
    <li>DCC will run a script to generate seperate LINKID files for Data Owners.</li>
    <li>Data Owners will translate the LINKIDs into PATIDs and insert this inforamtion into the LINK table.</li>

</ul>

<h3><a name="BulkData">FHIR Bulk Data</a></h3>
<p>FHIR Bulk Patient Data Requirements.</p>

<p>This implementation guide is a Domain of Knowledge IG. The purpose of this IG is to show how to represent clinical concepts generally, not to have a complete set of agreements for interoperable exchanges.</p>

<h3><a name="Disclaimers">Disclaimers and Known Limitations</a></h3>
<p></p>
<ul>
    <li>PPRL Limitations?</li>
</ul>

<h3><a name="Credits">Credits</a></h3>
<p>Authored by the CODI project at MITRE, sponsored by ___</p>
<p>This IG was authored by the MITRE Corporation using <a href="http://build.fhir.org/ig/HL7/fhir-shorthand/" target="_blank">FHIR Shorthand (FSH)</a> and <a href="https://github.com/FHIR/sushi" target="_blank">SUSHI</a>, a free, open source toolchain from <a href="https://www.mitre.org/" target="_blank">MITRE Corporation</a>.</p>

<h3><a name="Contacts">Contact Information</a></h3>
<table width="100%">
    <tbody>
    <tr>
    <td width="20%">
    <p>General Inquiries:</p>
    </td>
    <td width="80%">
    <p><a href="mailto:rscalfani@mitre.org">rscalfani@mitre.org</a></p>
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

MITRE: NOT Approved for Public Release. Distribution Unlimited. Case Number XXX

</div>
