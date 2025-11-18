#!/bin/bash

# Demo script to test kubeconfig-switcher functionality

echo "=== Kubeconfig Switcher Demo ==="
echo

echo "1. Showing help:"
kctx --help
echo
echo "Press Enter to continue..."
read

echo "2. Listing available configs:"
kctx --list
echo
echo "Press Enter to continue..."
read

echo "3. Showing current config:"
kctx --current
echo
echo "Press Enter to continue..."
read

echo "4. Switching to 'test' config:"
kctx test
echo
echo "Press Enter to continue..."
read

echo "5. Verifying the switch:"
kctx --current
echo
echo "Press Enter to continue..."
read

echo "6. Switching to 'prod' config:"
kctx prod
echo
echo "Press Enter to continue..."
read

echo "7. Verifying the switch:"
kctx --current
echo
echo "Press Enter to continue..."
read

echo "8. Testing error handling (non-existent config):"
kctx nonexistent
echo

echo "=== Demo Complete ==="
