# PowerShell-Build

Build tools for Powershell modules

# Usage

Create `appveyor.yml` in your project root with the following content:

```yaml
version: '{build}'
skip_tags: true

environment:
  StatementCoverageThreshold: 0
  FunctionCoverageThreshold: 0
  SkipUnitTests: true
  SkipDocumentation: true
  #SkipScriptAnalysis: true
  NuGetApiKey:
    secure: EaMePsm8eU/bUd1Ej83dTOAaGja/ht/3IrKC84nbZ9+dQbjeDfbTHk7nM+wp9DgE
  GitHubToken:
    secure: LznJHcvQE4ZRnDPWnayvawgr7VSpwH6ImeN6OK6tmLh5UHKdfZu6qKQ+ZBbkei73
  CoverallsToken:
    secure: /ngZ21bXk70+rS+xerRSmrIhpLu1l0mMICu62uo8Lp4YMlRCn5HoG3sBl/X2zRDv

os: WMF 5

build: false

test_script:
- ps: . .\build\Start-Build.ps1 -Task Deploy
```