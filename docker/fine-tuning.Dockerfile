FROM pytorch/pytorch:2.1.0-cuda12.1-cudnn8-devel

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY llm/ /app/llm/
COPY fine_tuning/ /app/fine_tuning/
COPY config/ /app/config/

# Environment variables
ENV PYTHONUNBUFFERED=1
ENV TRANSFORMERS_CACHE=/app/models/cache
ENV HF_HOME=/app/models/cache

# Volume mounts for data and models
VOLUME ["/app/data", "/app/models"]

# Set Python path
ENV PYTHONPATH=/app:$PYTHONPATH

# Entry point
CMD ["python", "-m", "fine_tuning.engine"]
