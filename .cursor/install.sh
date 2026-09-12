#!/usr/bin/env bash
# Idempotent Cloud Agent install script for ACE-Step 1.5.
#
# Installs the `uv` toolchain (if missing) and syncs project dependencies from
# pyproject.toml into a local .venv. Safe to run repeatedly.
set -euo pipefail

# 1. Install uv (Python package/dependency manager) if it is not already present.
if ! command -v uv >/dev/null 2>&1 && [ ! -x "${HOME}/.local/bin/uv" ]; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="${HOME}/.local/bin:${PATH}"

# 2. Resolve and install dependencies into .venv (idempotent).
#    On Linux x86_64 this pulls the CUDA 12.8 PyTorch build; it also runs on
#    CPU-only hosts, where torch.cuda.is_available() is simply False.
uv sync

echo "ACE-Step install complete. Activate with: source .venv/bin/activate (or use 'uv run ...')."
