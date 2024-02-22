Import-Module AzureAD
Import-Module ExchangeOnlineManagement 

# Parameters for the script
param(
    [string]$UserName, # Username for authentication
    [string]$Password, # Password for authentication
    [switch]$MFA           # Enable Multi-Factor Authentication
)

# Function to connect to Azure AD using provided credentials
function Connect-AzureAdWithCredentials {
    if ($MFA) {
        Connect-AzureAD   # Connect with Multi-Factor Authentication
    }
    else {
        # Convert plain-text password to secure string
        $SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force
        # Create credentials object
        $Credential = New-Object System.Management.Automation.PSCredential ($UserName, $SecurePassword)
        # Connect to Azure AD using credentials
        Connect-AzureAD -Credential $Credential
    }
}

# Additional function to retrieve mailbox permissions
function Get-MailboxPermissions {
    param(
        [string]$UserPrincipalName   # User Principal Name for mailbox
    )
    # Integrate with Exchange Online to retrieve mailbox permissions
    # Return sample values for demonstration purposes
    return @{
        MailboxType    = "UserMailbox"
        AccessType     = "FullAccess"
        UserWithAccess = "user@example.pl"
        Roles          = "No roles"
    }
}

# Function to generate user report
function Generate-UserReport {
    # Export path for data
    $exportPath = "yourCustomPath"
    # Connect to Azure AD using provided credentials
    Connect-AzureAdWithCredentials -UserName $UserName -Password $Password -MFA:$MFA
    # Retrieve all Azure AD users
    $users = Get-AzureADUser -All $true
    # Prepare user data and export to CSV
    $userDetails = $users | ForEach-Object {
        $permissions = Get-MailboxPermissions -UserPrincipalName $_.UserPrincipalName
        # Create custom PSObject with user data
        [PSCustomObject]@{
            DisplayName       = $_.DisplayName
            UserPrincipalName = $_.UserPrincipalName
            MailboxType       = $permissions.MailboxType
            AccessType        = $permissions.AccessType
            UserWithAccess    = $permissions.UserWithAccess
            Roles             = $permissions.Roles
        }
    }
    # Export data to CSV file
    $userDetails | Export-Csv -Path $exportPath -NoTypeInformation -Encoding UTF8
    Write-Host "Report has been saved to $exportPath"
}

# Call the function to generate the report
Generate-UserReport