# PPRL FHIR IG

As part of the Centers for Disease Control and Prevention’s (CDC) efforts to promote health, prevent disease, injury, and disability, and prepare for emerging health threats, the Division of Nutrition, Physical Activity, and Obesity; and Center for Surveillance, Epidemiology, and Laboratory Services partnered with the CMS Alliance to Modernize Healthcare federally funded research and development center (Health FFRDC) for the [Clinical and Community Data Initiative (CODI)](https://www.cdc.gov/obesity/initiatives/codi/community-and-clinical-data-initiative.html).

Privacy Preserving Record Linkage (PPRL) is a process in which multiple records for a single patient are linked without compromising or exposing their privacy or identities.

Communities track and store different kinds of health-related information, such as data about health care, SDOH, and community supports and services. Each organization therefore creates its own partial record of an individual’s health. A common challenge for population health analyses is linking an individual’s information across sectors and organizations while preserving privacy. PPRL aims to solve this issue without compromising Personally Identifiable Information (PII) or privacy by conducting record linkages between patient records without any PII data leaving the boundaries of an organization. This allows researchers to more accurately assess population health by providing complete health histories for individual patients without compromising their privacies or identities.

This Implementation Guide specifies how a PPRL process can be conducted when Data Owners retain patient information in FHIR enabled systems. It specifies the processes for extracting information for obfuscation as well as how linkage information can be communicated back to a Data Owner.

This Implementation Guide is written using [FHIR Shorthand](http://hl7.org/fhir/uv/shorthand/). See the [SUSHI documentation](https://fshschool.org/docs/sushi/) for instructions on building this IG.

## Notice

Copyright 2022 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 22-0042