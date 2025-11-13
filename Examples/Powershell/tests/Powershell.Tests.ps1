# Requires -Module Pester
Import-Module -Name Pester -MinimumVersion 5.0.0
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
$sut = (Resolve-Path "$here/../Powershell.psm1")

Describe "Powershell" {
    BeforeAll {
        Import-Module $sut
    }

    It "Should do something" {
        { 1 | Should -Be 1 } | Should -Not -Throw
    }
}
