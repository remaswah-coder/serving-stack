import os
from fastapi import FastAPI, HTTPException, Header, Request
from pydantic import BaseModel
from transformers import AutoModelForCausalLM, AutoTokenizer, pipeline

app = FastAPI(title="AIDC Model Serving Service")

# Read environment configurations
MODEL_ID = os.environ.get("MODEL_ID", "Qwen/Qwen2.5-0.5B-Instruct")
API_KEY = os.environ.get("API_KEY", "")
MAX_TOKENS_CEILING = int(os.environ.get("MAX_TOKENS", "256"))

# Startup warning if API key is missing
if not API_KEY:
    print("[WARNING] API_KEY environment variable is unset. Service is running unauthenticated!")

# Load Model & Tokenizer on startup
print(f"[*] Loading model {MODEL_ID}...")
tokenizer = AutoTokenizer.from_pretrained(MODEL_ID)
model = AutoModelForCausalLM.from_pretrained(MODEL_ID, torch_dtype="auto", device_map="cpu")
generator = pipeline("text-generation", model=model, tokenizer=tokenizer)
print("[+] Model loaded successfully.")

class ChatRequest(BaseModel):
    model: str
    messages: list
    max_tokens: int = 64

@app.get("/health")
def health_check():
    return {"status": "healthy", "model": MODEL_ID}

@app.post("/v1/chat/completions")
async def chat_completions(request: Request, body: ChatRequest, authorization: str = Header(None)):
    # Step 4 Security: Enforce API Key on /v1/* routes (excluding /health)
    if API_KEY:
        expected_header = f"Bearer {API_KEY}"
        if authorization != expected_header:
            raise HTTPException(status_code=401, detail="Unauthorized: Invalid or missing API key.")

    # Step 4 Security: Clamp max_tokens to prevent unbounded resource exhaustion (OWASP LLM10)
    requested_tokens = body.max_tokens
    clamped_tokens = min(requested_tokens, MAX_TOKENS_CEILING)

    # Format prompt from messages
    prompt = " ".join([m.get("content", "") for m in body.messages])
    
    # Generate inference
    outputs = generator(prompt, max_new_tokens=clamped_tokens, do_sample=True, temperature=0.7)
    generated_text = outputs[0]["generated_text"]

    return {
        "id": "chat-completion-1",
        "object": "chat.completion",
        "choices": [
            {
                "index": 0,
                "message": {"role": "assistant", "content": generated_text},
                "finish_reason": "stop"
            }
        ],
        "usage": {
            "prompt_tokens": len(tokenizer.encode(prompt)),
            "completion_tokens": clamped_tokens,
            "total_tokens": len(tokenizer.encode(prompt)) + clamped_tokens
        }
    }