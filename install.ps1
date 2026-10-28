<#
.SYNOPSIS
    brutal-crafter - Script de Instalação Universal para Windows (PowerShell)

.DESCRIPTION
    Instala e configura a skill brutal-crafter para múltiplos assistentes de IA:
    - Google Antigravity (%USERPROFILE%\.antigravity\skills e %USERPROFILE%\.gemini\antigravity-cli\skills)
    - Gemini CLI & Code Assist (%USERPROFILE%\.gemini\skills)
    - Claude Code (%USERPROFILE%\.claude\skills e local CLAUDE.md)
    - OpenCode (%USERPROFILE%\.config\opencode\skills e local .opencode\skills)
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
    Instala no OpenCode (%USERPROFILE%\.config\opencode\skills e %USERPROFILE%\.opencode\skills).

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
    Força a cópia física limpa dos 2 itens essenciais (padrão).

.PARAMETER Uninstall
    Remove a skill dos alvos selecionados ou de todos.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1
    # Auto-detecta e instala nos agentes presentes com cópia limpa.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -Project
    # Instala no projeto atual com agent-rules-books e regras locais.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -Symlink
    # Instala criando junções/links simbólicos (ideal para dev).

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -All
    # Instala para todos os agentes suportados.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -Uninstall -All
    # Remove a skill de todos os ambientes.
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
$SkillName = "brutal-crafter"

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
  powershell -ExecutionPolicy Bypass -File .\install.ps1 [OPÇÕES]

Opções de Alvo:
  -All                     Instala em todos os agentes suportados
  -Gemini, -Antigravity    Instala no Google Antigravity e Gemini CLI
  -Claude                  Instala no Claude Code (%USERPROFILE%\.claude\skills)
  -OpenCode                Instala no OpenCode (%USERPROFILE%\.config\opencode\skills)
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
  -Copy                    Cópia limpa dos 2 itens essenciais (padrão)
  -Uninstall               Remove a skill dos agentes selecionados
  -Help                    Exibe esta ajuda

Exemplos:
  .\install.ps1                      # Instalação com auto-detecção inteligente
  .\install.ps1 -Project             # Instala no projeto ativo com livros de regras
  .\install.ps1 -OpenCode            # Instala apenas no OpenCode
  .\install.ps1 -All                 # Instala em todos os agentes
  .\install.ps1 -Symlink             # Instala com Junction/Symlink
  .\install.ps1 -Uninstall -All      # Remove de todos os agentes
"@ -ForegroundColor Yellow
}

if ($Help) {
    Show-HelpMessage
    exit 0
}

if ($Antigravity) { $Gemini = $true }
if ($Roo) { $Cline = $true }
if ($Local) { $Project = $true }

# Valida pasta fonte
$SkillFile = Join-Path $ScriptDir "SKILL.md"
if (-not (Test-Path $SkillFile)) {
    Write-Err "SKILL.md não encontrado em $ScriptDir!"
    exit 1
}

$BooksDir = Join-Path $ScriptDir "agent-rules-books"
if (-not (Test-Path $BooksDir)) {
    Write-Warn "agent-rules-books\ não encontrado. A skill rodará sem a base de livros clássicos."
}

# Função de deploy de pasta (cópia limpa dos 2 itens essenciais ou junction/symlink)
function Deploy-SkillFolder($targetDir, [bool]$asSymlink) {
    $parent = Split-Path -Parent $targetDir
    if (-not (Test-Path $parent)) {
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
    }

    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force | Out-Null
    }

    if ($asSymlink) {
        try {
            # Tenta Junction (não exige admin no Windows moderno)
            New-Item -ItemType Junction -Path $targetDir -Target $ScriptDir -ErrorAction Stop | Out-Null
            Write-Success "Junção (Junction) criada: $targetDir -> $ScriptDir"
            return
        }
        catch {
            try {
                New-Item -ItemType SymbolicLink -Path $targetDir -Target $ScriptDir -ErrorAction Stop | Out-Null
                Write-Success "Link simbólico criado: $targetDir -> $ScriptDir"
                return
            }
            catch {
                Write-Warn "Não foi possível criar link simbólico ou junction. Realizando cópia física limpa..."
            }
        }
    }

    # Cópia física limpa dos 2 itens essenciais: SKILL.md e agent-rules-books\
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $targetDir -Force

    if (Test-Path $BooksDir) {
        $targetBooksDir = Join-Path $targetDir "agent-rules-books"
        New-Item -ItemType Directory -Path $targetBooksDir -Force | Out-Null
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $targetBooksDir -Recurse -Force
    }

    if (Test-Path (Join-Path $ScriptDir "README.md")) {
        Copy-Item -Path (Join-Path $ScriptDir "README.md") -Destination $targetDir -Force
    }
    if (Test-Path (Join-Path $ScriptDir "LICENSE")) {
        Copy-Item -Path (Join-Path $ScriptDir "LICENSE") -Destination $targetDir -Force
    }

    # Aliases de compatibilidade
    Copy-Item -Path (Join-Path $targetDir "SKILL.md") -Destination (Join-Path $targetDir "CLAUDE.md") -Force
    Copy-Item -Path (Join-Path $targetDir "SKILL.md") -Destination (Join-Path $targetDir ".cursorrules") -Force
    Write-Success "Cópia limpa realizada com sucesso para: $targetDir"
}

# Deploy no projeto ativo local
function Deploy-ProjectLocal([bool]$asSymlink) {
    $currentDir = (Get-Location).Path
    Write-Info "Instalando no projeto ativo ($currentDir)..."

    $cursorRules = Join-Path $currentDir ".cursorrules"
    $claudeMd = Join-Path $currentDir "CLAUDE.md"
    $githubDir = Join-Path $currentDir ".github"
    $copilotInstructions = Join-Path $githubDir "copilot-instructions.md"
    $localBooksDir = Join-Path $currentDir "agent-rules-books"
    $localOpenCodeDir = Join-Path $currentDir ".opencode\skills\$SkillName"

    if (-not (Test-Path $githubDir)) { New-Item -ItemType Directory -Path $githubDir -Force | Out-Null }

    if ($asSymlink) {
        try {
            New-Item -ItemType SymbolicLink -Path $cursorRules -Target (Join-Path $ScriptDir "SKILL.md") -Force | Out-Null
            New-Item -ItemType SymbolicLink -Path $claudeMd -Target (Join-Path $ScriptDir "SKILL.md") -Force | Out-Null
            New-Item -ItemType SymbolicLink -Path $copilotInstructions -Target (Join-Path $ScriptDir "SKILL.md") -Force | Out-Null
            if (Test-Path $BooksDir) {
                New-Item -ItemType Junction -Path $localBooksDir -Target $BooksDir -Force | Out-Null
            }
            $openCodeParent = Split-Path -Parent $localOpenCodeDir
            if (-not (Test-Path $openCodeParent)) { New-Item -ItemType Directory -Path $openCodeParent -Force | Out-Null }
            New-Item -ItemType Junction -Path $localOpenCodeDir -Target $ScriptDir -Force | Out-Null
            Write-Success "Symlinks/Junctions criados no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode, agent-rules-books)."
            return
        }
        catch {
            Write-Warn "Falha ao criar symlink no projeto ativo. Realizando cópia física limpa..."
        }
    }

    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $cursorRules -Force
    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $claudeMd -Force
    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $copilotInstructions -Force

    if (Test-Path $BooksDir) {
        if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
    }

    if (-not (Test-Path $localOpenCodeDir)) { New-Item -ItemType Directory -Path $localOpenCodeDir -Force | Out-Null }
    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $localOpenCodeDir -Force
    if (Test-Path $BooksDir) {
        $opencodeBooks = Join-Path $localOpenCodeDir "agent-rules-books"
        if (-not (Test-Path $opencodeBooks)) { New-Item -ItemType Directory -Path $opencodeBooks -Force | Out-Null }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $opencodeBooks -Recurse -Force
    }

    Write-Success "Cópia limpa realizada no projeto ativo (.cursorrules, CLAUDE.md, .github, .opencode, agent-rules-books)."
}

function Remove-SkillFolder($targetDir) {
    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force | Out-Null
        Write-Success "Removido: $targetDir"
    } else {
        Write-Info "Não instalado ou já removido: $targetDir"
    }
}

function Configure-CursorRule([bool]$asSymlink) {
    $currentDir = (Get-Location).Path
    $cursorRules = Join-Path $currentDir ".cursorrules"
    $localBooksDir = Join-Path $currentDir "agent-rules-books"

    if ($asSymlink) {
        try {
            New-Item -ItemType SymbolicLink -Path $cursorRules -Target (Join-Path $ScriptDir "SKILL.md") -Force | Out-Null
            if (Test-Path $BooksDir) {
                New-Item -ItemType Junction -Path $localBooksDir -Target $BooksDir -Force | Out-Null
            }
            Write-Success "Regra Cursor configurada via symlink (.cursorrules -> SKILL.md)"
        }
        catch {
            Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $cursorRules -Force
            if (Test-Path $BooksDir) {
                if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
                Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
            }
            Write-Success "Regra Cursor e agent-rules-books copiados (.cursorrules)"
        }
    } else {
        Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $cursorRules -Force
        if (Test-Path $BooksDir) {
            if (-not (Test-Path $localBooksDir)) { New-Item -ItemType Directory -Path $localBooksDir -Force | Out-Null }
            Copy-Item -Path (Join-Path $BooksDir "*") -Destination $localBooksDir -Recurse -Force
        }
        Write-Success "Regra Cursor e agent-rules-books copiados (.cursorrules)"
    }

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

    if ($asSymlink) {
        try {
            New-Item -ItemType SymbolicLink -Path $destFile -Target (Join-Path $ScriptDir "SKILL.md") -Force | Out-Null
            if (Test-Path $BooksDir) {
                New-Item -ItemType Junction -Path $localBooksDir -Target $BooksDir -Force | Out-Null
            }
            Write-Success "Instruções do Copilot configuradas via symlink ($destFile)"
            return
        }
        catch {
            Write-Warn "Falha ao criar symlink para Copilot. Realizando cópia física..."
        }
    }

    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $destFile -Force
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

# Auto-detecção se nenhum alvo foi informado
$userProfile = [System.Environment]::GetFolderPath('UserProfile')
if (-not $All -and -not $Gemini -and -not $Claude -and -not $OpenCode -and -not $Codex -and -not $Project -and -not $Cursor -and -not $Windsurf -and -not $Copilot -and -not $Cline -and -not $Aider -and -not $Continue -and ($Target -eq "")) {
    if ((Test-Path (Join-Path $userProfile ".antigravity")) -or (Test-Path (Join-Path $userProfile ".gemini"))) { $Gemini = $true }
    if (Test-Path (Join-Path $userProfile ".claude")) { $Claude = $true }
    if ((Test-Path (Join-Path $userProfile ".config\opencode")) -or (Test-Path (Join-Path $userProfile ".opencode"))) { $OpenCode = $true }
    if (Test-Path (Join-Path $userProfile ".codex")) { $Codex = $true }

    # Fallback se nada for detectado
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

# Desinstalação
if ($Uninstall) {
    Write-Warn "Iniciando desinstalação do brutal-crafter..."
    if ($Gemini) {
        Remove-SkillFolder (Join-Path $userProfile ".antigravity\skills\$SkillName")
        Remove-SkillFolder (Join-Path $userProfile ".gemini\skills\$SkillName")
        Remove-SkillFolder (Join-Path $userProfile ".gemini\antigravity-cli\skills\$SkillName")
    }
    if ($Claude) {
        Remove-SkillFolder (Join-Path $userProfile ".claude\skills\$SkillName")
    }
    if ($OpenCode) {
        Remove-SkillFolder (Join-Path $userProfile ".config\opencode\skills\$SkillName")
        Remove-SkillFolder (Join-Path $userProfile ".opencode\skills\$SkillName")
    }
    if ($Codex) {
        Remove-SkillFolder (Join-Path $userProfile ".codex\skills\$SkillName")
    }
    if ($Target -ne "") {
        Remove-SkillFolder $Target
    }
    Write-Success "Desinstalação concluída."
    exit 0
}

$deployMode = if ($Symlink) { "Symlink / Junction (Desenvolvimento)" } else { "Cópia Limpa (2 itens essenciais)" }
Write-Info "Modo de deploy: $deployMode"

# 1. Antigravity & Gemini CLI
if ($Gemini) {
    Write-Info "Instalando para Google Antigravity & Gemini CLI..."
    Deploy-SkillFolder (Join-Path $userProfile ".antigravity\skills\$SkillName") $Symlink
    Deploy-SkillFolder (Join-Path $userProfile ".gemini\skills\$SkillName") $Symlink
    Deploy-SkillFolder (Join-Path $userProfile ".gemini\antigravity-cli\skills\$SkillName") $Symlink
}

# 2. Claude Code
if ($Claude) {
    Write-Info "Instalando para Claude Code..."
    Deploy-SkillFolder (Join-Path $userProfile ".claude\skills\$SkillName") $Symlink
}

# 3. OpenCode
if ($OpenCode) {
    Write-Info "Instalando para OpenCode..."
    Deploy-SkillFolder (Join-Path $userProfile ".config\opencode\skills\$SkillName") $Symlink
    if (Test-Path (Join-Path $userProfile ".opencode")) {
        Deploy-SkillFolder (Join-Path $userProfile ".opencode\skills\$SkillName") $Symlink
    }
}

# 4. OpenAI Codex / OpenDevin
if ($Codex) {
    Write-Info "Instalando para OpenAI Codex / OpenDevin..."
    Deploy-SkillFolder (Join-Path $userProfile ".codex\skills\$SkillName") $Symlink
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
    Deploy-SkillFolder $Target $Symlink
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Success "Pronto! brutal-crafter instalado com sucesso."
Write-Info "Comandos disponíveis no seu agente: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev"
