# Gemini API Integration for n8n

This module provides Gemini API integration for n8n workflows, enabling AI-powered automation with Google's latest Gemini models.

## Features

- **Gemini 2.0 Flash Support**: Latest experimental model
- **Multi-modal AI**: Text, image, and code generation
- **Streaming responses**: Real-time AI output
- **Custom node for n8n**: Drag-and-drop Gemini functionality
- **MCP integration**: Context-aware AI workflows

## Configuration

The Gemini API key is configured via environment variables:

```bash
GEMINI_API_KEY=your_api_key_here
GEMINI_MODEL=gemini-2.0-flash-exp
```

## Usage in n8n

### HTTP Request Method

Use the HTTP Request node with:
- **Method**: POST
- **URL**: `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp:generateContent`
- **Authentication**: Custom (x-goog-api-key header)
- **Body**: JSON with prompt

### Example Workflow

```json
{
  "contents": [{
    "role": "user",
    "parts": [{"text": "Your prompt here"}]
  }]
}
```

## Available Models

- `gemini-2.0-flash-exp` - Latest experimental model
- `gemini-2.5-flash` - Production-ready flash model
- `gemini-1.5-pro` - High-capability model
- `gemini-1.5-flash` - Fast, lightweight model

## API Documentation

Full API docs: https://ai.google.dev/gemini-api/docs
