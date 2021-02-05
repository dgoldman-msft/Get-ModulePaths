Function Get-ModulePaths {
	<#
		.SYNOPSIS
			Display module paths

		.DESCRIPTION
			This function dumps out module paths

		.EXAMPLE
			PS C:\> Gmp

		.EXAMPLE
			PS C:\> Get-ModulePath

		.NOTES
			None
	#>

	[Alias('gmp')]
	[CmdletBinding(DefaultParameterSetName = "Default")]
	param()

	process {
		"-" * 20 + "Module Paths" + "-" * 20
		$modpaths = New-Object -TypeName System.Collections.ArrayList
		$modpaths = $env:PSModulePath -split ';'
		foreach ($path in $modpaths) {
		if ($path.contains("$HOME")){ "CURRENTUSER Scope: $($path)"; continue }
		if ($path.contains('\Program Files\')){ "ALLUSERS Scope: $($path)"; continue }
		if ($path.contains("$env:ProgramFiles\PowerShell\Modules")){ "ALLUSERS Scope: $($path)"; continue  }
		if ($path.contains("system32")){ "System Wide Scope: $($path)"; continue  }
		else { "Other: $($path)" }
		}
	}
}