#!/bin/bash
# ========================================
# Capybara Petter — Deploy to Base Mainnet
# ========================================
#
# STEP 1: Get your private key from your seed phrase:
#   source ~/.zshenv && cast wallet private-key "YOUR SEED PHRASE HERE"
#
# STEP 2: Run this script with your private key:
#   bash deploy.sh YOUR_PRIVATE_KEY_HERE
#
# Example:
#   bash deploy.sh 0x1234abcd...
# ========================================

set -e
source ~/.zshenv 2>/dev/null

PRIVATE_KEY="$1"
if [ -z "$PRIVATE_KEY" ]; then
  echo "Usage: bash deploy.sh <PRIVATE_KEY>"
  echo ""
  echo "To get your private key from a seed phrase, run:"
  echo '  cast wallet private-key "word1 word2 word3 ... word12"'
  exit 1
fi

echo "Deploying CapybaraPetter to Base Mainnet..."
echo "RPC: https://mainnet.base.org"
echo ""

forge create \
  --rpc-url https://mainnet.base.org \
  --private-key "$PRIVATE_KEY" \
  --broadcast \
  CapybaraPetter.sol:CapybaraPetter

echo ""
echo "Done! Copy the 'Deployed to:' address above and tell Claude."
