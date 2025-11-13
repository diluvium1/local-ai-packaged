#!/bin/bash
# AI Automation Stack - One-Command Startup
# Launches n8n + Gemini + MCP + Tool Server

set -e

echo "🚀 AI Automation Stack - Startup Script"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "${RED}❌ Docker is not installed${NC}"
    echo "Install from: https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "${RED}❌ Docker Compose is not installed${NC}"
    echo "Install from: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "${GREEN}✔ Docker and Docker Compose found${NC}"
echo ""

# Check environment file
if [ ! -f ".env.automation" ]; then
    echo "${YELLOW}⚠️  .env.automation not found, creating from template...${NC}"
    cp .env.automation.example .env.automation
    echo ""
    echo "${RED}IMPORTANT: Edit .env.automation and add your GEMINI_API_KEY${NC}"
    echo "Get API key: https://aistudio.google.com/apikey"
    echo ""
    echo "After adding your key, run this script again."
    exit 1
fi

# Check if API key is set
if grep -q "your_gemini_api_key_here" .env.automation; then
    echo "${RED}❌ Please add your Gemini API key to .env.automation${NC}"
    echo "Get it from: https://aistudio.google.com/apikey"
    exit 1
fi

echo "${GREEN}✔ Environment configured${NC}"
echo ""

# Start services
echo "📦 Pulling Docker images..."
docker-compose -f docker-compose.automation.yml --env-file .env.automation pull

echo ""
echo "🚀 Starting services..."
docker-compose -f docker-compose.automation.yml --env-file .env.automation up -d

echo ""
echo "${GREEN}✅ Services started successfully!${NC}"
echo ""
echo "🌐 Access your services:"
echo "   n8n:         http://localhost:5678"
echo "   MCP Manager: http://localhost:8080"
echo "   Tool Server: http://localhost:8000"
echo ""
echo "🔑 Default credentials:"
echo "   Username: admin"
echo "   Password: (from .env.automation)"
echo ""
echo "📊 To view logs:"
echo "   docker-compose -f docker-compose.automation.yml logs -f"
echo ""
echo "🛑 To stop:"
echo "   docker-compose -f docker-compose.automation.yml down"
echo ""
echo "${GREEN}Happy Automating! 🎉${NC}"
echo "Documentation: README-AUTOMATION.md"
