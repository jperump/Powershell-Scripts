This is an effort to automate certificate request creation and automation of the merger of CA Signed reply to form the final signed pfx file. When there are too many certificates to keep track of, creating CSR for each cert every time it needs renewal is a painstaking process. This solution uses template file for getting the CSR created for submission to the CA signing authority.

The template.inf file needs to be created for each certificate and has to be filled in with the details. This is a one time process. Once the template is ready, it can be used over and over again. 

There are two parts of the solution.

1. Creating the CSR request
---------------------------
Using the 'CreateRequest.ps1' we can pass in the certificate name, and get the CSR created and saved to a location of preference. Here for example, the repository is created under 'D:\CERTIFICATES\CertificateRepository'

'certreq' creates the unsigned key pair and saves it in certificate store. Our scripts exports it out and saves it into a folder under the Certificate directory. CSR will be opened as a txt file, which can then be pasted into CA authorities website.

2. Accepting the CA reply
----------------------------
Code in 'AcceptReply.ps1' uses teh .p7b formatted CA signature, and merges with the unsigned pfx created using 'CreateRequest.ps1'. Final certificate will be copied to its own directory in the repository. For convenience and easier identification in the coming renewal cycles, all folders have the creation timestamps in the name