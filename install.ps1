<#
.SYNOPSIS
    brutal-crafter - Script de Instalação Universal para Windows (PowerShell)

.DESCRIPTION
    Instala e configura a skill brutal-crafter para múltiplos assistentes de IA:
    - Google Antigravity & Gemini CLI
    - Claude Code
    - OpenCode (%USERPROFILE%\.config\opencode e %USERPROFILE%\.opencode)
    - OpenAI Codex / OpenDevin (%USERPROFILE%\.codex)
    - Cursor IDE
    - Windsurf (Codeium)
    - GitHub Copilot
    - Roo Code / Cline
    - Aider (CONVENTIONS.md)
    - Continue.dev (.continue/prompts)

.PARAMETER All
    Instala em todos os agentes suportados / detectados.

.PARAMETER Gemini
    Instala no Google Antigravity e Gemini CLI (%USERPROFILE%\.gemini e %USERPROFILE%\.gemini\antigravity-cli).

.PARAMETER Antigravity
    Alias para -Gemini.

.PARAMETER Claude
    Instala no Claude Code (%USERPROFILE%\.claude\skills).

.PARAMETER OpenCode
    Instala no OpenCode (%USERPROFILE%\.config\opencode\skills e %USERPROFILE%\.opencode\skills).

.PARAMETER Codex
    Instala no OpenAI Codex / OpenDevin (%USERPROFILE%\.codex\skills).

.PARAMETER Cursor
    Configura regras para o Cursor IDE (.cursor\rules\brutal-crafter.mdc).

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
    Cria junção de diretório / link simbólico (ideal para desenvolvimento). Requer permissão ou Modo de Desenvolvedor no Windows. Se falhar, faz cópia automática.

.PARAMETER Uninstall
    Remove a skill dos alvos selecionados ou de todos.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1
    # Auto-detecta e instala nos agentes presentes (Gemini, Claude, OpenCode).

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -OpenCode
    # Instala especificamente no OpenCode.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -All
    # Instala para todos os agentes suportados.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\install.ps1 -Symlink
    # Instala criando links/junções diretas.

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
    [switch]$Cursor,
    [switch]$Windsurf,
    [switch]$Copilot,
    [switch]$Cline,
    [switch]$Roo,
    [switch]$Aider,
    [switch]$Continue,
    [string]$Target = "",
    [switch]$Symlink,
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
 brutal-crafter - Instalador Universal Windows (PowerShell)
==========================================================

Uso:
  powershell -ExecutionPolicy Bypass -File .\install.ps1 [OPÇÕES]

Opções de Alvo:
  -All                     Instala em todos os agentes suportados
  -Gemini, -Antigravity    Instala no Google Antigravity e Gemini CLI
  -Claude                  Instala no Claude Code (%USERPROFILE%\.claude\skills)
  -OpenCode                Instala no OpenCode (%USERPROFILE%\.config\opencode\skills)
  -Codex                   Instala no OpenAI Codex / OpenDevin (%USERPROFILE%\.codex\skills)
  -Cursor                  Configura regras para Cursor IDE
  -Windsurf                Configura regras para Windsurf (.windsurfrules)
  -Copilot                 Configura instruções para GitHub Copilot
  -Cline, -Roo             Configura regras para Cline / Roo Code
  -Aider                   Configura diretrizes para Aider (CONVENTIONS.md)
  -Continue                Configura prompt para Continue.dev (.continue\prompts)
  -Target <Caminho>        Diretório customizado de instalação

Modos:
  -Symlink                 Usa Junção / Link Simbólico (ideal para desenvolvimento)
  -Uninstall               Remove a skill dos agentes selecionados
  -Help                    Exibe esta ajuda

Exemplos:
  .\install.ps1                      # Instalação com auto-detecção inteligente
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

# Função de deploy de pasta
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
                Write-Warn "Não foi possível criar link simbólico ou junction (falta de permissão). Realizando cópia física..."
            }
        }
    }

    # Cópia física
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Copy-Item -Path (Join-Path $ScriptDir "SKILL.md") -Destination $targetDir -Force
    if (Test-Path (Join-Path $ScriptDir "README.md")) {
        Copy-Item -Path (Join-Path $ScriptDir "README.md") -Destination $targetDir -Force
    }
    if (Test-Path (Join-Path $ScriptDir "ESTRUTURA.md")) {
        Copy-Item -Path (Join-Path $ScriptDir "ESTRUTURA.md") -Destination $targetDir -Force
    }
    $targetBooksDir = Join-Path $targetDir "agent-rules-books"
    if (Test-Path $BooksDir) {
        if (-not (Test-Path $targetBooksDir)) {
            New-Item -ItemType Directory -Path $targetBooksDir -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $BooksDir "*") -Destination $targetBooksDir -Recurse -Force
    }

    # Aliases de compatibilidade
    Copy-Item -Path (Join-Path $targetDir "SKILL.md") -Destination (Join-Path $targetDir "CLAUDE.md") -Force
    Copy-Item -Path (Join-Path $targetDir "SKILL.md") -Destination (Join-Path $targetDir ".cursorrules") -Force
    Write-Success "Copiado com sucesso para: $targetDir"
}

function Remove-SkillFolder($targetDir) {
    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force | Out-Null
        Write-Success "Removido: $targetDir"
    } else {
        Write-Info "Não instalado ou já removido: $targetDir"
    }
}

function Configure-CursorRule {
    $userProfile = [System.Environment]::GetFolderPath('UserProfile')
    $globalDir = Join-Path $userProfile ".cursor\rules"
    $localDir = Join-Path (Get-Location) ".cursor\rules"

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

Consulte a documentação completa da skill em SKILL.md.
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

function Configure-CopilotRule {
    $githubDir = Join-Path (Get-Location) ".github"
    if (-not (Test-Path $githubDir)) { New-Item -ItemType Directory -Path $githubDir -Force | Out-Null }
    $destFile = Join-Path $githubDir "copilot-instructions.md"
    $snippet = @"

## brutal-crafter - Princípios de Engenharia
- Respostas diretas à ação (ADHD mode: passos numerados, <= 5 itens por lista, zero preâmbulos).
- Comandos: /bc-x (auditoria), /bc-plan (planejamento), /bc-task (tarefas), /bc-craft (plano + tarefas), /bc-dev (execução).
- Priorize robustez de produção: timeouts, resiliência, idempotência e módulos profundos.
"@
    if ((Test-Path $destFile) -and ((Get-Content $destFile -Raw) -match "brutal-crafter")) {
        Write-Info "Instruções do Copilot já contêm brutal-crafter em $destFile"
    } else {
        Add-Content -Path $destFile -Value $snippet -Encoding UTF8
        Write-Success "Instruções do Copilot adicionadas a: $destFile"
    }
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

$UserProfile = [System.Environment]::GetFolderPath('UserProfile')
$GeminiSkillsDir = Join-Path $UserProfile ".gemini\skills\$SkillName"
$AntigravitySkillsDir = Join-Path $UserProfile ".gemini\antigravity-cli\skills\$SkillName"
$ClaudeSkillsDir = Join-Path $UserProfile ".claude\skills\$SkillName"
$OpenCodeConfigDir = Join-Path $UserProfile ".config\opencode\skills\$SkillName"
$OpenCodeHomeDir = Join-Path $UserProfile ".opencode\skills\$SkillName"
$CodexSkillsDir = Join-Path $UserProfile ".codex\skills\$SkillName"

# Auto-detecção inteligente se nada for passado
if (-not ($All -or $Gemini -or $Antigravity -or $Claude -or $OpenCode -or $Codex -or $Cursor -or $Windsurf -or $Copilot -or $Cline -or $Roo -or $Aider -or $Continue -or $Target)) {
    if (Test-Path (Join-Path $UserProfile ".gemini")) { $Gemini = $true }
    if (Test-Path (Join-Path $UserProfile ".claude")) { $Claude = $true }
    if ((Test-Path (Join-Path $UserProfile ".config\opencode")) -or (Test-Path (Join-Path $UserProfile ".opencode"))) { $OpenCode = $true }
    if (Test-Path (Join-Path $UserProfile ".codex")) { $Codex = $true }

    # Fallback padrão se nada for detectado
    if (-not ($Gemini -or $Claude -or $OpenCode)) {
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
    $Cursor = $true
    $Windsurf = $true
    $Copilot = $true
    $Cline = $true
    $Aider = $true
    $Continue = $true
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " brutal-crafter - Instalador Universal Windows" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Desinstalação
if ($Uninstall) {
    Write-Warn "Iniciando desinstalação do brutal-crafter..."
    if ($Gemini -or $Antigravity) {
        Remove-SkillFolder $GeminiSkillsDir
        Remove-SkillFolder $AntigravitySkillsDir
    }
    if ($Claude) {
        Remove-SkillFolder $ClaudeSkillsDir
    }
    if ($OpenCode) {
        Remove-SkillFolder $OpenCodeConfigDir
        Remove-SkillFolder $OpenCodeHomeDir
    }
    if ($Codex) {
        Remove-SkillFolder $CodexSkillsDir
    }
    if ($Target) {
        Remove-SkillFolder $Target
    }
    Write-Success "Desinstalação concluída."
    exit 0
}

# Instalação
if ($Gemini -or $Antigravity) {
    Write-Info "Instalando para Google Antigravity & Gemini CLI..."
    Deploy-SkillFolder $GeminiSkillsDir $Symlink
    Deploy-SkillFolder $AntigravitySkillsDir $Symlink
}

if ($Claude) {
    Write-Info "Instalando para Claude Code..."
    Deploy-SkillFolder $ClaudeSkillsDir $Symlink
}

if ($OpenCode) {
    Write-Info "Instalando para OpenCode..."
    Deploy-SkillFolder $OpenCodeConfigDir $Symlink
    if (Test-Path (Join-Path $UserProfile ".opencode")) {
        Deploy-SkillFolder $OpenCodeHomeDir $Symlink
    }
}

if ($Codex) {
    Write-Info "Instalando para OpenAI Codex / OpenDevin..."
    Deploy-SkillFolder $CodexSkillsDir $Symlink
}

if ($Cursor) {
    Write-Info "Configurando regras para Cursor IDE..."
    Configure-CursorRule
}

if ($Windsurf) {
    Write-Info "Configurando regras para Windsurf..."
    Configure-WindsurfRule
}

if ($Copilot) {
    Write-Info "Configurando instruções para GitHub Copilot..."
    Configure-CopilotRule
}

if ($Cline -or $Roo) {
    Write-Info "Configurando regras para Cline / Roo Code..."
    Configure-ClineRule
}

if ($Aider) {
    Write-Info "Configurando diretrizes para Aider..."
    Configure-AiderRule
}

if ($Continue) {
    Write-Info "Configurando prompt para Continue.dev..."
    Configure-ContinueRule
}

if ($Target) {
    Write-Info "Instalando em diretório customizado: $Target..."
    Deploy-SkillFolder $Target $Symlink
}

Write-Host "==========================================================" -ForegroundColor Green
Write-Success "brutal-crafter instalado com sucesso no Windows!"
Write-Info "Comandos disponíveis no seu agente: /bc-x, /bc-plan, /bc-task, /bc-craft, /bc-dev"
