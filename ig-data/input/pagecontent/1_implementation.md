<div xmlns="http://www.w3.org/1999/xhtml" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://hl7.org/fhir ../../input-cache/schemas-r5/fhir-single.xsd">

<h3><a name="ImplementationRequirements"></a>Implementation and Conformance Requirements</h3>
<p>This page contains the implementation requirements for PPRL.</p>

<ul>
    <li>The EHR FHIR Server's patients MUST feature the following attributes:</li>
    <ul>
        <li>birthDate</li>
        <li>birthSex</li>
        <li>identifier</li>
        <li>id</li>
        <li>name.given</li>
        <li>name.family</li>
        <li>contact.name.given</li>
        <li>contact.name.family</li>
        <li>address.line</li>
        <li>address.postalCode</li>
        <li>telecom[phoneNumber]</li>
        <li>telecom[email]</li>
        <li>The required patient attributes can also be seen in the <a href="StructureDefinition-pprl-patient.html">PPRLPatient Structure Definition</a></li>
    </ul>
    <li>The EHR FHIR Server MUST implement a FHIR Bulk Data Exportor that exports all patients so that they may be PPRL'd. It should export the patients in the NDJSON format presribed by <a href="https://hl7.org/fhir/uv/bulkdata/" target="_blank">FHIR Bulk Data Export Requirements</a>.</li>
</ul>

</div>
