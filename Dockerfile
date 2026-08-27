FROM python:3.11-slim

WORKDIR /app

# INTENTIONAL BUG (Day 3): Copying everything before installing dependencies 
# invalidates the pip install cache on any code-only edit. 
# Students will fix this by decoupling requirements.txt and app/ copy steps.
COPY . .

RUN pip install --no-cache-dir -r app/requirements.txt

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]