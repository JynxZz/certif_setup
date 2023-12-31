#!/bin/bash

# ---------------------------------------------------------------------------------
# Author: JynxZz
# Date Created: [2023-12-05]
# Script Description: Test to check all packages install in the environement
# ---------------------------------------------------------------------------------

# Waiting spinner
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "   %c   " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Define common required packages
REQUIRED_COMMON=('pytest' 'pylint' 'ipdb' 'PyYAML' 'nbresult' 'autopep8' 'flake8' 'yapf' 'lxml' 'requests' 'beautifulsoup4' 'jupyterlab' 'pandas' 'matplotlib' 'seaborn' 'plotly' 'scikit-learn' 'pandas-profiling' 'nbconvert' 'xgboost' 'statsmodels' 'jupyter-resource-usage')

# Determine architecture-specific required packages
arch_name="$(uname -m)"
if [ "${arch_name}" = "x86_64" ] && [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
  arch_name='m1'
elif [ "${arch_name}" = "arm64" ]; then
  arch_name='m1'
fi

# Adjust required packages based on architecture
REQUIRED=("${REQUIRED_COMMON[@]}")
if [ "$arch_name" = 'm1' ]; then
  REQUIRED+=('tensorflow-macos')
else
  REQUIRED+=('tensorflow')
fi

# Get currently installed packages
PACKAGES=$(pip freeze)

# Initialize array for missing packages
missing=()

# Check each required package
for required_pkg in "${REQUIRED[@]}"; do
  echo "Checking: $required_pkg" &
  spinner $!
  if ! echo "$PACKAGES" | grep -qE "^$required_pkg="; then
    missing+=("$required_pkg")
  fi
done

# Install missing packages
if [ ${#missing[@]} -gt 0 ]; then
  echo '❌ Some packages are missing and will be installed:'
  for pkg in "${missing[@]}"; do
    echo "Installing: $pkg"
    pip install --quiet "$pkg" &
  spinner $!
  done
  echo -e '✅ All missing packages have been installed.\n'
else
  echo -e '✅ Everything is fine, continue the setup instructions.\n'
fi
