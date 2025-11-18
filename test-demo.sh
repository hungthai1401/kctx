#!/bin/bash

# Demo script to test kubeconfig-switcher functionality

echo "=== Kubeconfig Switcher Demo ==="
echo

echo "1. Showing help:"
./kubeconfig-switcher.sh --help
echo
echo "Press Enter to continue..."
read

echo "2. Listing available configs:"
./kubeconfig-switcher.sh --list
echo
echo "Press Enter to continue..."
read

echo "3. Showing current config:"
./kubeconfig-switcher.sh --current
echo
echo "Press Enter to continue..."
read

echo "4. Switching to 'test' config:"
./kubeconfig-switcher.sh test
echo
echo "Press Enter to continue..."
read

echo "5. Verifying the switch:"
./kubeconfig-switcher.sh --current
echo
echo "Press Enter to continue..."
read

echo "6. Switching to 'prod' config:"
./kubeconfig-switcher.sh prod
echo
echo "Press Enter to continue..."
read

echo "7. Verifying the switch:"
./kubeconfig-switcher.sh --current
echo
echo "Press Enter to continue..."
read

echo "8. Testing error handling (non-existent config):"
./kubeconfig-switcher.sh nonexistent
echo

echo "=== Demo Complete ==="
