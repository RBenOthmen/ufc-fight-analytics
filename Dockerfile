# Use official Python image with specific version for stability
FROM python:3.9-slim

# Set working directory in container
WORKDIR /app

# Install system dependencies that some Python packages need
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for better Docker caching)
COPY requirements.txt .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files to container
COPY . .

# Create necessary directories
RUN mkdir -p notebooks data src

# Expose ports
EXPOSE 8888
EXPOSE 8501

# Default command - runs Jupyter lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]