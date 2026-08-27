# w2d5-lab-starter

# Lab W2D5: Student Step-by-Step Workflow

Follow these steps sequentially to complete, test, and submit your lab assignment.

---

## Step 1: Fork / Use Template
1. Go to the repository template provided by your instructor on GitHub.
2. Click the **"Use this template"** button at the top right.
3. Create your own repository under your personal or team GitHub account (e.g., `your-username/w2d5-lab-starter`). Ensure it is set to public or shared properly with your grading instructors.

## Step 2: Local Development
Clone your newly created repository to your local machine and complete the core tasks:
1. **Clone the repo locally:**
   ```bash
   git clone [https://github.com/your-username/w2d5-lab-starter.git](https://github.com/your-username/w2d5-lab-starter.git)
   cd aidc-serving

Clone your newly created repository to your local machine and complete the core tasks:
2. **Fill out your details in teams.md:**

3. **Fill out your project team details in projects.md:**

Fix Layer Caching (Day 3): Modify your Dockerfile to decouple dependency installation from source code copying so your build cache behaves efficiently.

Write compose.yaml (Day 5): Create your orchestration file from scratch, utilizing the Python healthcheck script and named volume (hf-cache).

Implement Security & Limits (Step 4): Update app/main.py to enforce Bearer token authentication (API_KEY) on /v1/* routes (leaving /health unauthenticated) and clamp token consumption via MAX_TOKENS.

Fill out Roster & Project Details: Complete your team information in teams.md and your capstone details in PROJECTS.md.

Step 3: Test Locally
Verify that your service builds, orchestrates, and passes all checks:

Copy the environment template and configure your local .env:

Bash
cp .env.example .env
# Edit .env with your local parameters
Build, run, and verify using the automated script:

Bash
./verify.sh
(Ensure it finishes with GREEN CHECK: PASS)

Step 4: Commit and Push
Ensure your local .env file is git-ignored and never committed.

Stage and commit all required files (compose.yaml, updated Dockerfile, updated app/main.py, teams.md, PROJECTS.md, and .env.example):

Bash
git add .
git commit -m "feat: complete docker compose orchestration and security hardening"
git push origin main
Step 5: Submission
Copy your final repository GitHub URL.

Submit your repository URL to the instructor or via your course management portal for grading.