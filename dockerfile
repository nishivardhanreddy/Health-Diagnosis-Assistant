# Use a smaller Python image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy only necessary files first to leverage Docker caching
COPY requirements.txt /app/

# Install dependencies with optimizations
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app/

# Ensure Training.csv and Testing.csv are in place
COPY Training.csv /app/
COPY Testing.csv /app/

# Expose only the required port
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "predictor.py", "--server.port=8501", "--server.address=0.0.0.0"]
