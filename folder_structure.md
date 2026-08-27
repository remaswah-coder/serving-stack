├── .env.example                # Template with placeholder variables (IMAGE, MODEL_ID, etc.)
├── .gitignore                  # Must contain .env and hf-cache/
├── Dockerfile                  # The broken Day 3 Dockerfile (for them to fix layer caching)
├── app/                        
│   ├── main.py                 # FastAPI base application (needs API_KEY & MAX_TOKENS additions in Step 4)
│   └── requirements.txt        # Python dependencies (FastAPI, uvicorn, transformers, torch, etc.)
├── teams.md                    # Template for team metadata and modality answers
├── verify.sh                   # The automated verification script provided to students
└── README.md                   # The lab instructions guide