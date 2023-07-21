$thousands = @('', 'Thousand', 'Million', 'Billion', 'Trillion', 'Quadrillion', 'Quintillion')
$ones = @('', 'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Eleven', 'Twelve', 'Thirteen', 'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen')
$tens = @('', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety')

function NumberToTextInner {
    param (
        [Parameter(Mandatory=$true)]
        [bigint]$Num
    )

    $result = [System.Text.StringBuilder]::new()
    
    if ($Num -lt 0) {
        $Num = -$Num
        [void]$result.Append('Negative')
    }
    
    if ($Num -ge 1000)
    {
        for ($i = 6; $i -ge 1; $i--) {
            $thousand = [Math]::Pow(1000, $i)
            if ($Num -ge $thousand)
            {
                $how_many = $Num / $thousand
                $how_many_text = NumberToTextInner -Num $how_many
                $thousand_text = $thousands[$i]
                if ($how_many -gt 1) {
                    $thousand_text = $thousand_text + 's'
                }
                [void]$result.Append(" $how_many_text $thousand_text")
                $Num = $Num - $how_many * $thousand
            }
        }
    }

    if ($Num -ge 100)
    {
        for ($i = 9; $i -ge 1; $i--) {
            $hundred = 100 * $i
            if ($Num -ge $hundred)
            {
                $how_many_text = NumberToTextInner -Num $i

                $hundred_text = 'Hundred'
                if ($i -gt 1) {
                    $hundred_text = $hundred_text + 's'
                }

                [void]$result.Append(" $how_many_text $hundred_text")
                $Num = $Num - $hundred
                break
            }
        }
    }

    if ($Num -ge 20)
    {
        for ($i = 9; $i -ge 2; $i--) {
            $ten = 10 * $i
            if ($Num -ge $ten)
            {
                [void]$result.Append(" $($tens[$i])")
                $Num = $Num - $ten
                break
            }
        }
    }
    
    if ($Num -gt 0) {
        [void]$result.Append(" $($ones[$Num])")
    }
    
    return $result.ToString().Trim()
}

function NumberToText {
    param (
        [Parameter(Mandatory = $true)]
        [bigint]$Number
    )

    if ($Number -eq 0) {
        return "Zero"
    }
    
    return NumberToTextInner -Num $Number
}

Export-ModuleMember -Function NumberToText