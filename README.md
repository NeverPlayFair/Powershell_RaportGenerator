First step will be install needed modules to import in code write this in terminal in vscode or in your cmd or windows powershell:

Install-Module -Name AzureAD

Install-Module -Name ExchangeOnlineManagement

How it works:

Parameters: The script takes three parameters: $UserName (username for authentication), $Password (password for authentication), and $MFA (a switch to enable Multi-Factor Authentication).

Connecting to Azure AD: The Connect-AzureAdWithCredentials function establishes a connection to Azure AD using the provided credentials. If Multi-Factor Authentication ($MFA) is enabled, it connects using MFA.

Retrieving User Data: The script retrieves all users from Azure AD using the Get-AzureADUser cmdlet and stores them in the $users variable.

Retrieving Mailbox Permissions: The Get-MailboxPermissions function (which simulates retrieving permissions from Exchange Online) is called for each user to retrieve mailbox permissions. This function returns sample values for demonstration purposes.

Generating the Report: The script prepares user data, including display name, user principal name, mailbox type, access type, user with access, and roles. It then exports this data to a CSV file using the Export-Csv cmdlet.

Execution: Finally, the Generate-UserReport function is called to execute the entire process and generate the report.
