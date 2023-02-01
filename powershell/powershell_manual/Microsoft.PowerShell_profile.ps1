Clear-Host

# Set Default location
Set-Location D:

# function prompt { $p = Split-Path -leaf -path (Get-Location) "$p> " }

# function prompt { "[$(('mirjr@dev'+$PWD).replace($HOME, '~'))]> " }

# function prompt { "$( ( Get-Location | Get-Item ).Name )>" }

# function prompt {'mirjr@dev:' + $(Get-Location | Split-Path -Leaf) + "$ "}

function Write-BranchName () {
	try {
		$branch = git rev-parse --abbrev-ref HEAD

		if ($branch -eq "HEAD") {
			# we're probably in detached HEAD state, so print the SHA
			$branch = git rev-parse --short HEAD
			Write-Host " ($branch)" -ForegroundColor "red"
		}
		else {
			# we're on an actual branch, so print it
			Write-Host " ($branch)" -ForegroundColor "blue"
		}
	}
 catch {
		# we'll end up here if we're in a newly initiated git repo
		Write-Host " (no branches yet)" -ForegroundColor "yellow"
	}
}

function Prompt {
	$base = "mirjr@$env:COMPUTERNAME "
	$date = (get-date -Format "yyyy-MM-dd HH:mm:ss")
	$path = "$($executionContext.SessionState.Path.CurrentLocation)" # $(Get-Location | Split-Path -Leaf)
	$userPrompt = "$('$' * ($nestedPromptLevel + 1)) "

	Write-Host "`n$base" -ForegroundColor DarkGreen -NoNewline
	Write-Host "$date" -ForegroundColor Yellow -NoNewline
	Write-Host " | " -ForegroundColor DarkGray -NoNewline

	if (Test-Path .git) {
		Write-Host $path -NoNewline -ForegroundColor Yellow
		Write-BranchName
	}
	else {
		# we're not in a repo so don't bother displaying branch name/sha
		Write-Host $path -ForegroundColor Yellow
	}

	return $userPrompt
}


# Arxiv
# function prompt
# {
#     write-host "mirjr@$env:COMPUTERNAME " -ForegroundColor DarkGreen -NoNewline
#     write-host (get-date -Format "yyyy-MM-dd HH:mm:ss") -ForegroundColor Yellow -NoNewline
#     write-host " | " -ForegroundColor DarkGray -NoNewline
#     if( (Get-Location).Drive -ne $null)
#     {
#         write-host (Get-Location) 
#         $networkdrive = $false
#     }
#     else
#     {
#         $networkdrive = $true
#         $first, $second, $third, $folder = (Get-Location).path.Split("\")
#         write-host "\" -NoNewline
#         $folder | foreach-object {
#             write-host "\$_" -NoNewline
#         }
#         write-host
#     }
#     write-host "$" -NoNewline
#     return " "
# }
