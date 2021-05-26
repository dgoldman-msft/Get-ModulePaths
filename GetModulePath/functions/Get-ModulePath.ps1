Function Get-ModulePath {
	<#
		.SYNOPSIS
			Display module paths

		.DESCRIPTION
			This function dumps out module paths

		.PARAMETER ShowProfiles
			This will display all of the interactive host's PowerShell profiles on the sytem
			
		.PARAMETER OpenProfilePaths
			This will open all profile paths in Windows Explorer

		.EXAMPLE
			PS C:\> Gmp

		.EXAMPLE
			PS C:\> GetModulePath

		.EXAMPLE
			PS C:\> GetModulePath -ShowProfiles

		.EXAMPLE
			PS C:\> GetModulePath -OpenProfilePaths

		.NOTES
			NOTE: You can not pull up the help information until the object has been imported
	#>

	[Alias('getmp')]
	[CmdletBinding(DefaultParameterSetName = "Default")]
	param(
		[switch]
		$ShowProfiles,
		
		[switch]
		$OpenProfilePaths
	)
	
	begin{
		Write-PSFMessage -String 'GetModulePath.Message1'
		$modpaths = New-Object -TypeName System.Collections.ArrayList
		$modpaths = $env:PSModulePath -split ';'
	}

	process {
		if($ShowProfiles){
			$profile | Select-Object *Host* | Format-List
			return
		}
		
		if($OpenProfilePaths){
			$counter = 0
			foreach($path in $modpaths) { 
			Write-PSFMessage -Level Host -Message "[<c='Green'>{0}</c>]: <c='Yellow'>{1}</c>" -StringValues $counter, $path
			$counter++ } 
	
            $answer = Read-Host "Which module path do you want to open?"
            Invoke-Item $modpaths[$answer] -ErrorAction SilentlyContinue
			return
		}

		"_" * 52
		foreach ($path in $modpaths) {
		if ($path.contains("$HOME")){ "CURRENTUSER Scope: $($path)"; continue }
		if ($path.contains('\Program Files\')){ "ALLUSERS Scope: $($path)"; continue }
		if ($path.contains("$env:ProgramFiles\PowerShell\Modules")){ "ALLUSERS Scope: $($path)"; continue  }
		if ($path.contains("system32")){ "System Wide Scope: $($path)"; continue  }
		else { "Other: $($path)" }
		}
	}
}