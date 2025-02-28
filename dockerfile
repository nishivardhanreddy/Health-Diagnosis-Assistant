# Use the official Python image as a base
FROM python:3.9

# Set the working directory in the container
WORKDIR /app

# Copy all files to the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the Streamlit port
EXPOSE 80

# Run the application
CMD ["streamlit", "run", "predictor.py", "--server.port=80", "--server.address=0.0.0.0"]
