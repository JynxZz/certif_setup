#!/bin/bash

# ---------------------------------------------------------------------------------
# Author: JynxZz
# Date Created: [2023-12-05]
# Script Description: This script automates the setup of a Python development environment, including OS checks, virtual environment creation,
# Python version validation, and installation of required packages based on the detected OS.
# ---------------------------------------------------------------------------------

red='\e[30m'
green='\e[32m'
blue='\e[34m'
clear='\e[0m'

# Waiting spinner
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "%c" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

#TODO: Check Os
function check_os() {
  local os_type

  # Use uname to determine the OS and architecture
  case "$(uname -s)" in
      Linux*)     os_type="Linux";;
      Darwin*)
          # Check for macOS architecture
          local arch=$(uname -m)
          if [ "$arch" = "x86_64" ]; then
              os_type="Mac_Intel"
          elif [ "$arch" = "arm64" ]; then
              os_type="Mac_Silicon"
          else
              os_type="Mac_Unknown"
          fi
          ;;
      CYGWIN*|MINGW*) os_type="Windows";;
      *)          os_type="UNKNOWN";;
  esac

  echo $os_type
}

#TODO: Setup virtual Env
function setup_virtual_env() {
  echo -e "\n${blue}####################$clear"

  env_name="lewagon_certif"
  selected_version="3.10.6"

  echo "Creating the $env_name with Python version $selected_version"
  pyenv virtualenv "$selected_version" "$env_name"

  echo -e "\nSetting up the new Virtual Environment locally..."
  pyenv local "$env_name"

  echo -e "\nUpdating Pip..."
  python3 -m pip install --quiet --upgrade pip
}

#TODO: Create Certtif Zone
fucntion check_dir(){
  certification_dir="$HOME/code/certification"

  if [ ! -d "$certification_dir" ]; then
      echo "Creating directory: $certification_dir"
      mkdir -p "$certification_dir"
  else
      echo "Directory already exists: $certification_dir"
  fi
  cd "$certification_dir"
}

#TODO: Checking Python3.10.6 installed
function check_python_version(){
  echo -e "\n${blue}####################$clear"
  target_version="3.10.6"

  # Check if pyenv is installed
  if ! command -v pyenv &> /dev/null; then
      echo "pyenv is not installed. Please install pyenv first."
      exit 1
  fi

  # Check python version
  if pyenv versions --bare | grep -q "^$target_version\$"; then
      echo "Python $target_version is already installed in pyenv."
  else
      echo "Python $target_version is not installed. Installing now..."
      pyenv install $target_version

      # Verify installation
      if pyenv versions --bare | grep -q "^$target_version\$"; then
          echo "Python $target_version has been successfully installed."
      else
          echo "Failed to install Python $target_version."
          exit 1
      fi
  fi
}


# Main Zone
# Get the operating system type
echo -e "\n${blue}####################$clear"
os_type=$(check_os)
echo "Detected OS: $os_type"
check_python_version
check_dir
setup_virtual_env

case $os_type in
  Mac_Intel)
      echo -e "\n${blue}####################$clear"
      echo -e "\nPerforming operations for macOS Intel."
      pip install --quiet -r https://raw.githubusercontent.com/lewagon/data-setup/master/specs/releases/apple_intel.txt &
      spinner $!
      ;;
  Mac_Silicon)
      echo -e "\n${blue}####################$clear"
      echo -e "\nPerforming operations for macOS Silicon."
      pip install --quiet -r https://raw.githubusercontent.com/lewagon/data-setup/master/specs/releases/apple_silicon.txt &
      spinner $!
      ;;
  Linux)
      echo -e "\n${blue}####################$clear"
      echo -e "\nPerforming operations for Linux."
      pip install --quiet -r https://raw.githubusercontent.com/lewagon/data-setup/master/specs/releases/linux.txt &
      spinner $!
      ;;
  Windows)
      echo -e "\n${blue}####################$clear"
      echo -e "\nPerforming operations for Windows."
      echo "Hmmm ... maybe time to have a better OS"
      pip install --quiet -r https://raw.githubusercontent.com/lewagon/data-setup/master/specs/releases/linux.txt &
      spinner $!
      ;;
  *)
      echo -e "\n${blue}####################$clear"
      echo -e "\nOS not recognized. Exiting."
      exit 1
      ;;
esac


# Test all setup
echo -e "\n${blue}####################$clear"
echo -e "\nTesting the setup for the Certification 🐍"

zsh -c "$(curl -fsSL https://raw.githubusercontent.com/JynxZz/certif_setup/main/test_python.sh)"
zsh -c "$(curl -fsSL https://raw.githubusercontent.com/JynxZz/certif_setup/main/test_packages.sh)"
python -c "$(curl -fsSL https://raw.githubusercontent.com/JynxZz/certif_setup/main/test_setup.py)"


echo -e "\n${blue}####################$clear"
echo -e "Now, it's your turn to code ... "
echo -e "${green}GOOD LUCK !! $clear"
echo -e "💪 💪 💪 💪 💪 💪"
