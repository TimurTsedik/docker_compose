# Use official Python image as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy project
COPY . /app/

# Copy wait_for_postgres script
COPY wait_for_postgres.py /app/wait_for_postgres.py

# Expose the port that the app runs on
EXPOSE 8000

# Run the application
CMD ["sh", "-c", "python wait_for_postgres.py && python manage.py migrate && gunicorn --bind 0.0.0.0:8000 stocks_products.wsgi:application"]
