# PowerShell modules

In this repo I'll collect various PowerShell modules which can be useful for not just me

## NumberToText.psm1

This module exports just one `NumberToText` function which is converting integer number to its text representation (Example: `123` = `One Hundred Twenty Three`)

### Usage

```powershell

Import-Module "$PSScriptRoot/NumberToText.psm1"

Write-Host (NumberToText -Number 123456789)

# Will print "One Hundred Twenty Three Millions Four Hundreds Fifty Six Thousands Seven Hundreds Eighty Nine"

```
