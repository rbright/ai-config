#!/usr/bin/env bun
"use strict";

const fs = require("fs");
const { execSync } = require("child_process");

const colors = {
  red: '\x1b[1;31m',
  green: '\x1b[1;32m',
  yellow: '\x1b[1;33m',
  blue: '\x1b[1;34m',
  purple: '\x1b[1;35m',
  cyan: '\x1b[1;36m',
  white: '\x1b[1;37m',
  gray: '\x1b[1;90m',
  orange: '\x1b[1;38;5;208m',
  reset: '\x1b[0m'
};

const exec = (cmd, cwd = null) => {
  try {
    const options = { encoding: 'utf8', stdio: ['ignore', 'pipe', 'ignore'] };
    if (cwd) options.cwd = cwd;
    return execSync(cmd, options).trim();
  } catch {
    return '';
  }
};

function parseLine(rawLine) {
  const line = rawLine.trim();
  if (!line) return null;

  try {
    const parsed = JSON.parse(line);
    const ts = typeof parsed.timestamp === "string" ? new Date(parsed.timestamp).getTime() : parsed.timestamp;
    const usage = parsed.message?.usage;
    const role = parsed.message?.role;

    return { ts, usage, role };
  } catch {
    return null;
  }
}

function parseLatestUsage(lines) {
  if (!lines) return null;

  let latestUsage = null;
  let latestTs = -Infinity;

  for (let i = Math.max(0, lines.length - 50); i < lines.length; i++) {
    const parsedLine = parseLine(lines[i]);
    if (!parsedLine) continue;

    const { ts, usage, role } = parsedLine;
    if (ts <= latestTs || !usage || role !== "assistant") {
      continue;
    }

    latestTs = ts;
    latestUsage = usage;
  }

  return latestUsage;
}

function getLatestUsage(transcriptPath) {
  if (!transcriptPath) return null;

  try {
    const data = fs.readFileSync(transcriptPath, "utf8");
    const lines = data.split('\n');
    return parseLatestUsage(lines);
  } catch {
    return null;
  }
}

function getUsedTokens(latestUsage) {
  const inputTokens = latestUsage.input_tokens || 0;
  const outputTokens = latestUsage.output_tokens || 0;
  const cacheReadInputTokens = latestUsage.cache_read_input_tokens || 0;
  const cacheCreationInputTokens = latestUsage.cache_creation_input_tokens || 0;

  return inputTokens + outputTokens + cacheReadInputTokens + cacheCreationInputTokens;
}

function getContextPercentage(transcriptPath) {
  const latestUsage = getLatestUsage(transcriptPath);
  if (!latestUsage) return "0";

  const usedTokens = getUsedTokens(latestUsage);
  const percentage = Math.min(100, (usedTokens * 100) / 160000);

  return percentage >= 90 ? percentage.toFixed(1) : Math.round(percentage).toString();
}

function getPercentageColor(percentage) {
  if (percentage >= 90) return colors.red;
  if (percentage >= 70) return colors.orange;
  if (percentage >= 50) return colors.yellow;

  return colors.gray;
}

function getModelName(displayName) {
  if (displayName.includes('Opus')) return 'Opus';
  if (displayName.includes('Sonnet')) return 'Sonnet';
  if (displayName.includes('Haiku')) return 'Haiku';

  return 'Unknown';
}

function getModelDisplay(input) {
  const displayName = input.model?.display_name;
  if (!displayName) return '';

  const modelName = getModelName(displayName);
  const contextPercentage = getContextPercentage(input.transcript_path);
  const contextPercentageColor = getPercentageColor(parseFloat(contextPercentage));

  return ` ${colors.gray}• ${contextPercentageColor}${contextPercentage}% ${colors.gray}${modelName}${colors.reset}`;
}

function getBranchDisplay(input) {
  const currentDir = input.workspace?.current_dir;
  if (!currentDir) return '';

  const branch = exec('git branch --show-current', currentDir);
  if (!branch) return '';

  return `${colors.purple} ${branch}${colors.reset}`;
}

function getOutputStyle(input) {
  const outputStyle = input.output_style?.name;
  if (!outputStyle) return '';

  return `${colors.gray} • ${outputStyle}${colors.reset}`;
}

function getSessionIdDisplay(input) {
  const sessionId = input.session_id;
  if (!sessionId) return '';

  return `${colors.gray} • ${sessionId}${colors.reset}`;
}

function getInput() {
  try {
    return JSON.parse(fs.readFileSync(0, "utf8"));
  } catch {
    return {};
  }
}

function statusline() {
  const input = getInput();
  const branchDisplay = getBranchDisplay(input);
  const modelDisplay = getModelDisplay(input);
  const outputStyleDisplay = getOutputStyle(input);
  const sessionIdDisplay = getSessionIdDisplay(input);

  return `${branchDisplay}${modelDisplay}${outputStyleDisplay}${sessionIdDisplay}`;
}

process.stdout.write(statusline());