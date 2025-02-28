# Use the official Python image as a base
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy required files
COPY . /app
COPY Training.csv /app/
COPY Testing.csv /app/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Clear Streamlit cache (helps with deployment issues)
RUN streamlit cache clear

# Expose the correct port
EXPOSE 8501

# Run the application on port 8501
CMD ["streamlit", "run", "predictor.py", "--server.port=8501", "--server.address=0.0.0.0"]
