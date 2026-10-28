<#
.SYNOPSIS
    brutal-crafter - Script de Instalação Universal para Windows (PowerShell)

.DESCRIPTION
    Instala e configura a skill brutal-crafter e seus comandos oficiais:
    - /bc-craft, /bc-x, /bc-plan, /bc-task, /bc-dev e /brutal-crafter
    Para múltiplos assistentes de IA:
    - Google Antigravity (%USERPROFILE%\.antigravity\skills e %USERPROFILE%\.gemini\antigravity-cli\skills)
    - Gemini CLI & Code Assist (%USERPROFILE%\.gemini\skills e %USERPROFILE%\.gemini\commands)
    - Claude Code (%USERPROFILE%\.claude\skills e local CLAUDE.md)
    - OpenCode (%USERPROFILE%\.config\opencode\skills, commands e local .opencode)
    - OpenAI Codex / OpenDevin (%USERPROFILE%\.codex\skills)
    - Cursor AI / Windsurf (.cursorrules, .cursor\rules\brutal-crafter.mdc, .windsurfrules)
    - GitHub Copilot (.github\copilot-instructions.md)
    - Roo Code / Cline (.clinerules)
    - Aider (CONVENTIONS.md)
    - Continue.dev (.continue\prompts)

.PARAMETER All
    Instala em todos os agentes suportados / detectados.

.PARAMETER Gemini
    Instala no Google Antigravity e Gemini CLI (%USERPROFILE%\.antigravity e %USERPROFILE%\.gemini).

.PARAMETER Antigravity
    Alias para -Gemini.

.PARAMETER Claude
    Instala no Claude Code (%USERPROFILE%\.claude\skills).

.PARAMETER OpenCode
    Instala no OpenCode (%USERPROFILE%\.config\opencode\skills e commands).

.PARAMETER Codex
    Instala no OpenAI Codex / OpenDevin (%USERPROFILE%\.codex\skills).

.PARAMETER Project
    Instala no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode e agent-rules-books).

.PARAMETER Local
    Alias para -Project.

.PARAMETER Cursor
    Configura regras para o Cursor AI (.cursorrules e .cursor\rules\brutal-crafter.mdc).

.PARAMETER Windsurf
    Configura regras para o Windsurf (.windsurfrules local).

.PARAMETER Copilot
    Configura instruções para GitHub Copilot (.github\copilot-instructions.md local).

.PARAMETER Cline
    Configura regras para Cline / Roo Code (.clinerules local).

.PARAMETER Roo
    Alias para -Cline.

.PARAMETER Aider
    Configura diretrizes para o Aider (CONVENTIONS.md local).

.PARAMETER Continue
    Configura prompt customizado para o Continue.dev (.continue\prompts local).

.PARAMETER Target
    Caminho de diretório customizado para instalação da pasta da skill.

.PARAMETER Symlink
    Cria junção de diretório / link simbólico (ideal para desenvolvimento).

.PARAMETER Copy
    Força a cópia física limpa dos itens essenciais (padrão).

.PARAMETER Uninstall
    Remove a skill e sub-comandos dos alvos selecionados ou de todos.
#>

[CmdletBinding()]
param(
    [switch]$All,
    [switch]$Gemini,
    [switch]$Antigravity,
    [switch]$Claude,
    [switch]$OpenCode,
    [switch]$Codex,
    [switch]$Project,
    [switch]$Local,
    [switch]$Cursor,
    [switch]$Windsurf,
    [switch]$Copilot,
    [switch]$Cline,
    [switch]$Roo,
    [switch]$Aider,
    [switch]$Continue,
    [string]$Target = "",
    [switch]$Symlink,
    [switch]$Copy,
    [switch]$Uninstall,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (Test-Path (Join-Path $RepoRoot "SKILL.md")) {
    $RepoRoot = $ScriptDir
} else {
    $RepoRoot = Split-Path -Parent $ScriptDir
}
$SkillName = "brutal-crafter"
$SubCommands = @("bc-craft", "bc-x", "bc-plan", "bc-task", "bc-dev")

function Write-Info($msg)    { Write-Host "i [INFO] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "`u{2714} [SUCESSO] $msg" -ForegroundColor Green }
function Write-Warn($msg)    { Write-Host "`u{26A0} [AVISO] $msg" -ForegroundColor Yellow }
function Write-Err($msg)     { Write-Host "`u{2716} [ERRO] $msg" -ForegroundColor Red }

function Show-HelpMessage {
    Write-Host @"
==========================================================
 🧠 brutal-crafter - Instalador Universal Windows (PowerShell)
==========================================================

Uso:
  powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 [OPÇÕES]

Comandos Oficiais Registrados:
  /bc-craft              Planejamento 4 pilares + tarefas em disco + Jira MCP em 1 passo
  /bc-x                  Auditoria de codebase e varredura de riscos com fallback nativo
  /bc-plan               Planejamento de requisitos em 4 pilares sem over-engineering
  /bc-task               Detalhamento atômico de tarefas (- [ ]) em .docs/brutal-crafter/
  /bc-dev                Diretrizes e execução prática (-e) com validação e checklist (- [x])
  /brutal-crafter        Skill principal integrando todos os fluxos e persona sênior

Opções de Alvo:
  -All                     Instala em todos os agentes suportados
  -Gemini, -Antigravity    Instala no Google Antigravity e Gemini CLI
  -Claude                  Instala no Claude Code (%USERPROFILE%\.claude\skills)
  -OpenCode                Instala no OpenCode (%USERPROFILE%\.config\opencode\skills e commands)
  -Codex                   Instala no OpenAI Codex / OpenDevin (%USERPROFILE%\.codex\skills)
  -Project, -Local         Instala no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode, agent-rules-books)
  -Cursor                  Configura regras para Cursor AI
  -Windsurf                Configura regras para Windsurf (.windsurfrules)
  -Copilot                 Configura instruções para GitHub Copilot
  -Cline, -Roo             Configura regras para Cline / Roo Code
  -Aider                   Configura diretrizes para Aider (CONVENTIONS.md)
  -Continue                Configura prompt para Continue.dev (.continue\prompts)
  -Target <Caminho>        Diretório customizado de instalação

Modos:
  -Symlink                 Usa Junção / Link Simbólico (ideal para desenvolvimento)
  -Copy                    Cópia limpa dos itens essenciais (padrão)
  -Uninstall               Remove a skill dos agentes selecionados
  -Help                    Exibe esta ajuda

Exemplos:
  .\scripts\install.ps1                      # Instalação com auto-detecção e registro de /bc-*
  .\scripts\install.ps1 -Project             # Instala no projeto ativo com livros de regras
  .\scripts\install.ps1 -OpenCode            # Instala apenas no OpenCode
  .\scripts\install.ps1 -All                 # Instala em todos os agentes
  .\scripts\install.ps1 -Symlink             # Instala com Junction/Symlink
  .\scripts\install.ps1 -Uninstall -All      # Remove de todos os agentes
"@ -ForegroundColor Yellow
}

if ($Help) {
    Show-HelpMessage
    exit 0
}

if ($Antigravity) { $Gemini = $true }
if ($Roo) { $Cline = $true }
if ($Local) { $Project = $true }

$SkillFile = Join-Path $RepoRoot "SKILL.md"
if (-not (Test-Path $SkillFile)) {
    Write-Err "SKILL.md não encontrado em $RepoRoot!"
    exit 1
}

$BooksDir = Join-Path $RepoRoot "agent-rules-books"
if (-not (Test-Path $BooksDir)) {
    Write-Warn "agent-rules-books\ não encontrado. A skill rodará sem a base de livros clássicos."
}

function Deploy-SkillSuite($baseDir, [bool]$asSymlink) {
    if (-not (Test-Path $baseDir)) {
        New-Item -ItemType Directory -Path $baseDir -Force | Out-Null
    }

    # 1. Instala a skill principal: brutal-crafter
    $mainTarget = Join-Path $baseDir $SkillName
    if (Test-Path $mainTarget) {
        Remove-Item -Path $mainTarget -Recurse -Force | Out-Null
    }

    if ($asSymlink) {
        try {
            New-Item -ItemType Junction -Path $mainTarget -Target $RepoRoot -ErrorAction Stop | Out-Null
            Write-Success "Skill principal vinculada via Junction: $mainTarget"
        }
        catch {
            New-Item -ItemType Directory -Path $mainTarget -Force | Out-Null
            Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $mainTarget -Force
            if (Test-Path $BooksDir) {
                $targetBooks = Join-Path $mainTarget "agent-rules-books"
                New-Item -ItemType Directory -Path $targetBooks -Force | Out-Null
                Copy-Item -Path (Join-Path $BooksDir "*") -Destination $targetBooks -Recurse -Force
            }
            Write-Success "Skill principal copiada: $mainTarget"
        }
    } else {
        New-Item -ItemType Directory -Path $mainTarget -Force | Out-Null
        Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $mainTarget -Force
        if (Test-Path $BooksDir) {
            $targetBooks = Join-Path $mainTarget "agent-rules-books"
            New-Item -ItemType Directory -Path $targetBooks -Force | Out-Null
            Copy-Item -Path (Join-Path $BooksDir "*") -Destination $targetBooks -Recurse -Force
        }
        if (Test-Path (Join-Path $RepoRoot "README.md")) { Copy-Item -Path (Join-Path $RepoRoot "README.md") -Destination $mainTarget -Force }
        if (Test-Path (Join-Path $RepoRoot "LICENSE")) { Copy-Item -Path (Join-Path $RepoRoot "LICENSE") -Destination $mainTarget -Force }
        Copy-Item -Path (Join-Path $mainTarget "SKILL.md") -Destination (Join-Path $mainTarget "CLAUDE.md") -Force
        Copy-Item -Path (Join-Path $mainTarget "SKILL.md") -Destination (Join-Path $mainTarget ".cursorrules") -Force
        Write-Success "Skill principal copiada: $mainTarget"
    }

    # 2. Instala cada sub-comando como skill dedicada para aparecer no autocomplete /bc-*
    foreach ($cmd in $SubCommands) {
        $cmdTarget = Join-Path $baseDir $cmd
        if (Test-Path $cmdTarget) {
            Remove-Item -Path $cmdTarget -Recurse -Force | Out-Null
        }

        $sourceCmdDir = Join-Path (Join-Path $RepoRoot "skills") $cmd
        if ($asSymlink -and (Test-Path $sourceCmdDir)) {
            try {
                New-Item -ItemType Junction -Path $cmdTarget -Target $sourceCmdDir -ErrorAction Stop | Out-Null
                if (Test-Path $BooksDir) {
                    $cmdBooks = Join-Path $cmdTarget "agent-rules-books"
                    if (-not (Test-Path $cmdBooks)) {
                        New-Item -ItemType Junction -Path $cmdBooks -Target $BooksDir -Force -ErrorAction SilentlyContinue | Out-Null
                    }
                }
                Write-Success "Comando /$cmd registrado via Junction: $cmdTarget"
                continue
            }
            catch {}
        }

        New-Item -ItemType Directory -Path $cmdTarget -Force | Out-Null
        $cmdSkillFile = Join-Path $sourceCmdDir "SKILL.md"
        if (Test-Path $cmdSkillFile) {
            Copy-Item -Path $cmdSkillFile -Destination $cmdTarget -Force
        } else {
            Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $cmdTarget -Force
        }

        if (Test-Path $BooksDir) {
            $cmdBooksDir = Join-Path $cmdTarget "agent-rules-books"
            New-Item -ItemType Directory -Path $cmdBooksDir -Force | Out-Null
            Copy-Item -Path (Join-Path $BooksDir "*") -Destination $cmdBooksDir -Recurse -Force
        }
        Write-Success "Comando /$cmd registrado com cópia limpa: $cmdTarget"
    }
}

function Remove-SkillSuite($baseDir) {
    $mainTarget = Join-Path $baseDir $SkillName
    if (Test-Path $mainTarget) {
        Remove-Item -Path $mainTarget -Recurse -Force | Out-Null
        Write-Success "Removido: $mainTarget"
    }
    foreach ($cmd in $SubCommands) {
        $cmdTarget = Join-Path $baseDir $cmd
        if (Test-Path $cmdTarget) {
            Remove-Item -Path $cmdTarget -Recurse -Force | Out-Null
            Write-Success "Removido: $cmdTarget"
        }
    }
}

function Deploy-ProjectLocal([bool]$asSymlink) {
    $currentDir = (Get-Location).Path
    Write-Info "Instalando no projeto ativo ($currentDir)..."

    $cursorRules = Join-Path $currentDir ".cursorrules"
    $claudeMd = Join-Path $currentDir "CLAUDE.md"
    $githubDir = Join-Path $currentDir ".github"
    $copilotInstructions = Join-Path $githubDir "copilot-instructions.md"
    $localBooksDir = Join-Path $currentDir "agent-rules-books"
    $localOpenCodeDir = Join-Path $currentDir ".opencode\skills\$SkillName"
    $localCommandsDir = Join-Path $currentDir ".opencode\command"

    if (-not (Test-Path $githubDir)) { New-Item -ItemType Directory -Path $githubDir -Force | Out-Null }

    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $cursorRules -Force
    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $claudeMd -Force
    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $copilotInstructions -Force

    if (Test-Path $BooksDir) {
        if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
    }

    if (-not (Test-Path $localOpenCodeDir)) { New-Item -ItemType Directory -Path $localOpenCodeDir -Force | Out-Null }
    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $localOpenCodeDir -Force
    if (Test-Path $BooksDir) {
        $opencodeBooks = Join-Path $localOpenCodeDir "agent-rules-books"
        if (-not (Test-Path $opencodeBooks)) { New-Item -ItemType Directory -Path $opencodeBooks -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $opencodeBooks -Recurse -Force
    }

    $sourceOpenCodeCommands = Join-Path $RepoRoot ".opencode\command"
    if (Test-Path $sourceOpenCodeCommands) {
        if (-not (Test-Path $localCommandsDir)) { New-Item -ItemType Directory -Path $localCommandsDir -Force | Out-Null }
        Copy-Item -Path (Join-Path $sourceOpenCodeCommands "*") -Destination $localCommandsDir -Recurse -Force
    }

    Write-Success "Cópia limpa realizada no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode, agent-rules-books)."
}

function Configure-CursorRule([bool]$asSymlink) {
    $currentDir = (Get-Location).Path
    $cursorRules = Join-Path $currentDir ".cursorrules"
    $localBooksDir = Join-Path $currentDir "agent-rules-books"

    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $cursorRules -Force
    if (Test-Path $BooksDir) {
        if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
    }
    Write-Success "Regra Cursor e agent-rules-books copiados (.cursorrules)"

    $userProfile = [System.Environment]::GetFolderPath('UserProfile')
    $globalDir = Join-Path $userProfile ".cursor\rules"
    $localDir = Join-Path $currentDir ".cursor\rules"

    if (Test-Path $globalDir) {
        $destFile = Join-Path $globalDir "brutal-crafter.mdc"
    } else {
        if (-not (Test-Path $localDir)) { New-Item -ItemType Directory -Path $localDir -Force | Out-Null }
        $destFile = Join-Path $localDir "brutal-crafter.mdc"
    }

    $content = @"
---
description: brutal-crafter - Engenharia pragmática de ponta a ponta, sem over-engineering e com rigor técnico
globs: *
alwaysApply: true
---

# Brutal Crafter - Regras Ativas de Engenharia

Esta regra ativa as diretrizes e comandos do brutal-crafter:
- Comandos: `/bc-x` (Auditoria), `/bc-plan` (Planejamento), `/bc-task` (Tarefas), `/bc-craft` (Plano + Tarefas), `/bc-dev` (Hands-on)
- Flags: `-s` (Quick/ADHD), `-d` (Deep Dive), `-e` (Execute hands-on), `-j` (Jira MCP sync)
- Princípios: Good Taste, Never Break Userspace, Módulos Profundos, Zero Over-engineering.

Consulte as instruções completas em SKILL.md e agent-rules-books/.
"@
    Set-Content -Path $destFile -Value $content -Encoding UTF8
    Write-Success "Regra Cursor gerada: $destFile"
}

function Configure-WindsurfRule {
    $destFile = Join-Path (Get-Location) ".windsurfrules"
    $snippet = @"

# --- brutal-crafter ---
# Engenharia pragmática: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (-s/-d/-e/-j)
# Foco em ADHD (ação na 1ª linha, <= 5 itens), zero over-engineering e rigor técnico.
"@
    if ((Test-Path $destFile) -and ((Get-Content $destFile -Raw) -match "brutal-crafter")) {
        Write-Info "Regra Windsurf já presente em $destFile"
    } else {
        Add-Content -Path $destFile -Value $snippet -Encoding UTF8
        Write-Success "Regra Windsurf adicionada a: $destFile"
    }
}

function Configure-CopilotRule([bool]$asSymlink) {
    $currentDir = (Get-Location).Path
    $githubDir = Join-Path $currentDir ".github"
    if (-not (Test-Path $githubDir)) { New-Item -ItemType Directory -Path $githubDir -Force | Out-Null }
    $destFile = Join-Path $githubDir "copilot-instructions.md"
    $localBooksDir = Join-Path $currentDir "agent-rules-books"

    Copy-Item -Path (Join-Path $RepoRoot "SKILL.md") -Destination $destFile -Force
    if (Test-Path $BooksDir) {
        if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
    }
    Write-Success "Instruções Copilot e agent-rules-books copiados ($destFile)"
}

function Configure-ClineRule {
    $destFile = Join-Path (Get-Location) ".clinerules"
    $snippet = @"

# --- brutal-crafter ---
# Engenharia pragmática: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (-s/-d/-e/-j)
# Ação na 1ª linha, tarefas atômicas com checklist persistido em .docs/brutal-crafter/.
"@
    if ((Test-Path $destFile) -and ((Get-Content $destFile -Raw) -match "brutal-crafter")) {
        Write-Info "Regra Cline/Roo já presente em $destFile"
    } else {
        Add-Content -Path $destFile -Value $snippet -Encoding UTF8
        Write-Success "Regra Cline/Roo adicionada a: $destFile"
    }
}

function Configure-AiderRule {
    $destFile = Join-Path (Get-Location) "CONVENTIONS.md"
    $snippet = @"

# brutal-crafter - Diretrizes de Engenharia (Aider)
- Foco em ação imediata (ADHD mode: passos numerados, <= 5 itens por lista, zero preâmbulos).
- Comandos suportados: /bc-x (auditoria), /bc-plan (planejamento), /bc-task (tarefas), /bc-craft (plano + tarefas), /bc-dev (execução).
- Princípios: Good Taste (eliminar casos especiais na modelagem), Never Break Userspace, módulos profundos.
"@
    if ((Test-Path $destFile) -and ((Get-Content $destFile -Raw) -match "brutal-crafter")) {
        Write-Info "Diretrizes Aider já presentes em $destFile"
    } else {
        Add-Content -Path $destFile -Value $snippet -Encoding UTF8
        Write-Success "Diretrizes Aider adicionadas a: $destFile"
    }
}

function Configure-ContinueRule {
    $continueDir = Join-Path (Get-Location) ".continue\prompts"
    if (-not (Test-Path $continueDir)) { New-Item -ItemType Directory -Path $continueDir -Force | Out-Null }
    $destFile = Join-Path $continueDir "brutal-crafter.prompt"
    $content = @"
---
name: brutal-crafter
description: Engenharia de software pragmática de ponta a ponta sem over-engineering
---
<system>
Você é o Brutal Crafter: Arquiteto de Software e Engenheiro Principal Sênior.
Elimine o teatro corporativo, aplique os 4 pilares (Problema, Solução, Riscos, Melhorias).
Respostas orientadas à ação imediata (modo ADHD).
Comandos suportados: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev (flags -s, -d, -e, -j).
</system>

{{{ input }}}
"@
    Set-Content -Path $destFile -Value $content -Encoding UTF8
    Write-Success "Prompt Continue.dev gerado: $destFile"
}

$userProfile = [System.Environment]::GetFolderPath('UserProfile')
if (-not $All -and -not $Gemini -and -not $Claude -and -not $OpenCode -and -not $Codex -and -not $Project -and -not $Cursor -and -not $Windsurf -and -not $Copilot -and -not $Cline -and -not $Aider -and -not $Continue -and ($Target -eq "")) {
    if ((Test-Path (Join-Path $userProfile ".antigravity")) -or (Test-Path (Join-Path $userProfile ".gemini"))) { $Gemini = $true }
    if (Test-Path (Join-Path $userProfile ".claude")) { $Claude = $true }
    if ((Test-Path (Join-Path $userProfile ".config\opencode")) -or (Test-Path (Join-Path $userProfile ".opencode"))) { $OpenCode = $true }
    if (Test-Path (Join-Path $userProfile ".codex")) { $Codex = $true }

    if (-not $Gemini -and -not $Claude -and -not $OpenCode) {
        $Gemini = $true
        $Claude = $true
        $OpenCode = $true
    }
}

if ($All) {
    $Gemini = $true
    $Claude = $true
    $OpenCode = $true
    $Codex = $true
    $Project = $true
    $Cursor = $true
    $Windsurf = $true
    $Copilot = $true
    $Cline = $true
    $Aider = $true
    $Continue = $true
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🧠 brutal-crafter - Instalador Universal Windows (PowerShell)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

if ($Uninstall) {
    Write-Warn "Iniciando desinstalação do brutal-crafter e comandos..."
    if ($Gemini) {
        Remove-SkillSuite (Join-Path $userProfile ".antigravity\skills")
        Remove-SkillSuite (Join-Path $userProfile ".gemini\skills")
        Remove-SkillSuite (Join-Path $userProfile ".gemini\antigravity-cli\skills")
    }
    if ($Claude) {
        Remove-SkillSuite (Join-Path $userProfile ".claude\skills")
    }
    if ($OpenCode) {
        Remove-SkillSuite (Join-Path $userProfile ".config\opencode\skills")
        Remove-SkillSuite (Join-Path $userProfile ".opencode\skills")
    }
    if ($Codex) {
        Remove-SkillSuite (Join-Path $userProfile ".codex\skills")
    }
    if ($Target -ne "") {
        Remove-SkillSuite $Target
    }
    Write-Success "Desinstalação concluída."
    exit 0
}

$deployMode = if ($Symlink) { "Symlink / Junction (Desenvolvimento)" } else { "Cópia Limpa" }
Write-Info "Modo de deploy: $deployMode"

# 1. Antigravity & Gemini CLI
if ($Gemini) {
    Write-Info "Instalando para Google Antigravity & Gemini CLI (registrando /bc-* e /brutal-crafter)..."
    Deploy-SkillSuite (Join-Path $userProfile ".antigravity\skills") $Symlink
    Deploy-SkillSuite (Join-Path $userProfile ".gemini\skills") $Symlink
    Deploy-SkillSuite (Join-Path $userProfile ".gemini\antigravity-cli\skills") $Symlink
}

# 2. Claude Code
if ($Claude) {
    Write-Info "Instalando para Claude Code..."
    Deploy-SkillSuite (Join-Path $userProfile ".claude\skills") $Symlink
}

# 3. OpenCode
if ($OpenCode) {
    Write-Info "Instalando para OpenCode..."
    Deploy-SkillSuite (Join-Path $userProfile ".config\opencode\skills") $Symlink
    $sourceOpenCodeCommands = Join-Path $RepoRoot ".opencode\command"
    if (Test-Path $sourceOpenCodeCommands) {
        $destOpenCodeCommands = Join-Path $userProfile ".config\opencode\command"
        if (-not (Test-Path $destOpenCodeCommands)) { New-Item -ItemType Directory -Path $destOpenCodeCommands -Force | Out-Null }
        Copy-Item -Path (Join-Path $sourceOpenCodeCommands "*") -Destination $destOpenCodeCommands -Recurse -Force
    }
    if (Test-Path (Join-Path $userProfile ".opencode")) {
        Deploy-SkillSuite (Join-Path $userProfile ".opencode\skills") $Symlink
    }
}

# 4. OpenAI Codex / OpenDevin
if ($Codex) {
    Write-Info "Instalando para OpenAI Codex / OpenDevin..."
    Deploy-SkillSuite (Join-Path $userProfile ".codex\skills") $Symlink
}

# 5. Projeto Ativo (Local)
if ($Project) {
    Deploy-ProjectLocal $Symlink
}

# 6. Cursor
if ($Cursor) {
    Write-Info "Configurando regras para Cursor AI..."
    Configure-CursorRule $Symlink
}

# 7. Windsurf
if ($Windsurf) {
    Write-Info "Configurando regras para Windsurf..."
    Configure-WindsurfRule
}

# 8. GitHub Copilot
if ($Copilot) {
    Write-Info "Configurando instruções para GitHub Copilot..."
    Configure-CopilotRule $Symlink
}

# 9. Cline / Roo Code
if ($Cline) {
    Write-Info "Configurando regras para Cline / Roo Code..."
    Configure-ClineRule
}

# 10. Aider
if ($Aider) {
    Write-Info "Configurando diretrizes para Aider..."
    Configure-AiderRule
}

# 11. Continue.dev
if ($Continue) {
    Write-Info "Configurando prompt para Continue.dev..."
    Configure-ContinueRule
}

# 12. Custom Target
if ($Target -ne "") {
    Write-Info "Instalando no diretório customizado: $Target..."
    Deploy-SkillSuite $Target $Symlink
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Success "Pronto! brutal-crafter e comandos oficiais instalados com sucesso."
Write-Host "Comandos disponíveis no seu assistente:" -ForegroundColor Yellow
Write-Host "  /bc-craft [-s|-d] [-j]   (Planejamento 4 pilares + tarefas em disco + Jira em 1 passo)" -ForegroundColor Cyan
Write-Host "  /bc-x [-s|-d] [caminho]  (Auditoria de codebase com repomix ou fallback nativo)" -ForegroundColor Cyan
Write-Host "  /bc-plan [-s|-d]          (Requisitos e arquitetura em 4 pilares)" -ForegroundColor Cyan
Write-Host "  /bc-task [-s|-d] [-j]     (Detalhamento atômico em .docs/brutal-crafter/)" -ForegroundColor Cyan
Write-Host "  /bc-dev [-s|-d|-e]       (Diretrizes e execução hands-on com testes e checklist)" -ForegroundColor Cyan
Write-Host "  /brutal-crafter           (Skill principal integrando todos os fluxos)" -ForegroundColor Cyan
