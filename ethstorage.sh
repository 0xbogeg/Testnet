#!/bin/bash

# EthStorage Trusted Setup Ceremony Contribution Script
# Date: August 2025
# Version: 1.0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ASCII Art
echo -e "${BLUE}"
cat << "EOF"
  /$$$$$$            /$$$$$$$                                         
 /$$$_  $$          | $$__  $$                                        
| $$$$\ $$ /$$   /$$| $$  \ $$  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$ 
| $$ $$ $$|  $$ /$$/| $$$$$$$  /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$
| $$\ $$$$ \  $$$$/ | $$__  $$| $$  \ $$| $$  \ $$| $$$$$$$$| $$  \ $$
| $$ \ $$$  >$$  $$ | $$  \ $$| $$  | $$| $$  | $$| $$_____/| $$  | $$
|  $$$$$$/ /$$/\  $$| $$$$$$$/|  $$$$$$/|  $$$$$$$|  $$$$$$$|  $$$$$$$
 \______/ |__/  \__/|_______/  \______/  \____  $$ \_______/ \____  $$
                                         /$$  \ $$           /$$  \ $$
                                        |  $$$$$$/          |  $$$$$$/
                                         \______/            \______/
EOF
echo -e "${NC}"

echo -e "${YELLOW}\nWelcome to EthStorage V1 Trusted Setup Ceremony Contribution Script${NC}"
echo -e "Ceremony Period: August 13-22, 2025 (UTC)\n"

# Check if running as root

# Function to check command existence
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check dependencies
check_dependencies() {
    local missing=0
    
    if ! command_exists node; then
        echo -e "${RED}Error: Node.js is not installed.${NC}"
        missing=1
    else
        NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
        if [ "$NODE_VERSION" -lt 18 ]; then
            echo -e "${RED}Error: Node.js version must be 18 or higher. Current version: $(node -v)${NC}"
            missing=1
        fi
    fi
    
    if ! command_exists npm; then
        echo -e "${RED}Error: npm is not installed.${NC}"
        missing=1
    fi
    
    if ! command_exists curl; then
        echo -e "${RED}Error: curl is not installed.${NC}"
        missing=1
    fi
    
    if [ "$missing" -ne 0 ]; then
        exit 1
    fi
}

# Install NVM if not present
install_nvm() {
    if [ ! -d "$HOME/.nvm" ]; then
        echo -e "${YELLOW}Installing Node Version Manager (nvm)...${NC}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        source ~/.bashrc
    else
        echo -e "${GREEN}nvm is already installed.${NC}"
    fi
}

# Install Node.js 18
install_node() {
    if ! command_exists node || [ "$(node -v | cut -d'v' -f2 | cut -d'.' -f1)" -lt 18 ]; then
        echo -e "${YELLOW}Installing Node.js 18...${NC}"
        nvm install 18
        nvm use 18
    else
        echo -e "${GREEN}Node.js 18+ is already installed.${NC}"
    fi
}

# Main installation function
setup_environment() {
    echo -e "\n${BLUE}=== Setting Up Contribution Environment ===${NC}"
    check_dependencies
    
    if ! command_exists nvm; then
        install_nvm
        source ~/.bashrc
    fi
    
    install_node
    
    echo -e "\n${GREEN}✓ Environment setup complete${NC}"
}

# Contribution process
run_contribution() {
    echo -e "\n${BLUE}=== Starting Contribution Process ===${NC}"
    
    # Create temporary directory
    TEMP_DIR="$HOME/ethstorage-trusted-setup"
    if [ ! -d "$TEMP_DIR" ]; then
        mkdir -p "$TEMP_DIR"
        echo -e "${GREEN}Created temporary directory: $TEMP_DIR${NC}"
    fi
    
    cd "$TEMP_DIR" || exit
    
    # Install Phase2 CLI
    echo -e "\n${YELLOW}Installing Phase2 CLI...${NC}"
    npm install -g @p0tion/phase2cli
    
    # Authenticate with GitHub
    echo -e "\n${YELLOW}Authenticating with GitHub...${NC}"
    echo -e "A browser window will open for GitHub authentication."
    echo -e "Please authorize the application when prompted."
    phase2cli auth
    
    # Run contribution
    echo -e "\n${YELLOW}Starting contribution...${NC}"
    echo -e "This may take some time depending on your internet connection."
    phase2cli contribute -c ethstorage-v1-trusted-setup-ceremony
    
}

# Main execution
setup_environment
run_contribution

echo -e "\n${BLUE}=== EthStorage Trusted Setup Ceremony ===${NC}"
echo -e "Thank you for helping secure the future of decentralized storage!"
echo -e "Ceremony ends: August 22, 2025"
echo -e "Learn more: https://ethstorage.io"
