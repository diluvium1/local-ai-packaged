# AI Automation Stack - Self-Hosted n8n + Gemini + MCP + Tool Server

🚀 **Complete visual workflow automation platform with AI-powered capabilities**

Built for Diluvium - Run your own AI automation stack with n8n, Google Gemini AI, open-source MCP manager, and custom tool server.

## 🎯 What You Get

- **n8n**: Visual workflow automation (like Zapier/Make, but self-hosted)
- **Gemini AI**: Google's latest AI models integrated directly
- **MCP Manager**: Model Context Protocol for agent orchestration
- **Tool Server**: FastAPI-powered custom tools and endpoints
- **PostgreSQL**: Reliable database for workflows
- **Redis**: Fast caching layer (optional)

## 🖼️ Visual Workflow UI

This stack provides a Firefly/Freepik-style visual interface through n8n:
- Drag-and-drop node canvas
- Real-time workflow execution
- AI-powered automation with Gemini
- Custom integrations and tools

## ⚡ Quick Start (One Command)

```bash
# 1. Clone this repo
git clone https://github.com/diluvium1/local-ai-packaged.git
cd local-ai-packaged

# 2. Copy and configure environment
cp .env.automation.example .env.automation
nano .env.automation  # Add your GEMINI_API_KEY

# 3. Launch everything
docker-compose -f docker-compose.automation.yml --env-file .env.automation up -d
```

## 🔑 Get Your Gemini API Key

1. Visit: https://aistudio.google.com/apikey
2. Sign in with your Google account
3. Click "Create API Key"
4. Copy and paste into `.env.automation`

## 🌐 Access Your Services

Once running, access:

- **n8n**: http://localhost:5678 (Visual workflow editor)
- **MCP Manager**: http://localhost:8080 (Agent gateway)
- **Tool Server**: http://localhost:8000 (Custom tools API)
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379

Default credentials:
- **Username**: admin
- **Password**: change_this_n8n_password (set in .env.automation)

## 📁 Architecture

```
local-ai-packaged/
├── docker-compose.automation.yml   # Main orchestration
├── .env.automation.example         # Configuration template
├── gemini-integration/             # Gemini API modules
├── mcp-manager/                    # MCP gateway (build required)
├── tool-server/                    # FastAPI tools (build required)
└── README-AUTOMATION.md            # This file
```

## 🛠️ Building Components

### MCP Manager (Node.js)

Create `mcp-manager/Dockerfile`:
```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 8080
CMD ["node", "server.js"]
```

### Tool Server (Python FastAPI)

Create `tool-server/Dockerfile`:
```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## 🎨 Creating Workflows in n8n

1. Open n8n at http://localhost:5678
2. Create a new workflow
3. Add nodes:
   - **Trigger**: Webhook, Schedule, Manual
   - **Gemini AI**: HTTP Request to Gemini API
   - **MCP Tools**: Connect to http://mcp-manager:8080
   - **Custom Actions**: Call http://tool-server:8000/api/...

### Example: AI Content Generator

```
[Schedule Trigger] → [HTTP Request: Gemini] → [Process Response] → [Save to DB]
```

## 🔧 Configuration Options

Edit `.env.automation` to customize:

```bash
# n8n settings
N8N_PORT=5678
N8N_USER=your_username
N8N_PASSWORD=your_secure_password

# Gemini AI
GEMINI_API_KEY=your_key_here
GEMINI_MODEL=gemini-2.0-flash-exp

# Database
POSTGRES_PASSWORD=change_this_password
```

## 🚀 Deployment Options

### Local Development
```bash
docker-compose -f docker-compose.automation.yml --env-file .env.automation up
```

### Production (Cloud)

1. **DigitalOcean/AWS/GCP**:
   - Launch Docker-capable droplet/instance
   - Install Docker & Docker Compose
   - Clone repo and configure
   - Run with `-d` for background
   - Set up reverse proxy (Caddy/Nginx) for HTTPS

2. **Environment Variables for Production**:
```bash
N8N_HOST=your-domain.com
N8N_PROTOCOL=https
WEBHOOK_URL=https://your-domain.com/
```

## 🔒 Security Best Practices

- ✅ Change default passwords
- ✅ Use strong Gemini API key
- ✅ Enable HTTPS in production
- ✅ Restrict network access
- ✅ Regularly update Docker images
- ✅ Use secrets management for production

## 📊 Monitoring

Check service health:
```bash
docker-compose -f docker-compose.automation.yml ps
docker logs automation-n8n
docker logs automation-mcp-manager
docker logs automation-tool-server
```

## 🛑 Stop Services

```bash
docker-compose -f docker-compose.automation.yml down
```

Keep data:
```bash
docker-compose -f docker-compose.automation.yml down  # volumes preserved
```

Remove everything:
```bash
docker-compose -f docker-compose.automation.yml down -v
```

## 🆘 Troubleshooting

### n8n won't start
- Check PostgreSQL is running: `docker logs automation-postgres`
- Verify environment variables in `.env.automation`

### Gemini API errors
- Verify API key: https://aistudio.google.com/apikey
- Check quota limits
- Test with `curl`:
```bash
curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent" \
  -H "x-goog-api-key: YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{"contents":[{"parts":[{"text":"Hello"}]}]}'
```

### Port conflicts
- Change ports in `.env.automation`
- Kill conflicting services

## 🎓 Resources

- **n8n Documentation**: https://docs.n8n.io/
- **Gemini API Docs**: https://ai.google.dev/gemini-api/docs
- **MCP Protocol**: https://modelcontextprotocol.io/
- **FastAPI**: https://fastapi.tiangolo.com/

## 🤝 Support

For issues, questions, or contributions:
- Open an issue on GitHub
- Check existing documentation
- Contact: [Your Contact Info]

## 📝 License

Apache-2.0 - See LICENSE file

---

**Built with ❤️ for Diluvium**  
AI Automation Made Simple
