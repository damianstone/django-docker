# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Just copy the requirements
COPY requirements.txt /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# copy the entire code into the image
# copy the code at the end so docker wont install everything again for the next build
COPY . /app

RUN python manage.py makemigrations

RUN python manage.py migrate

# Expose port 8000 for the Django app
EXPOSE 8000

# Start the Django development serverr
# CMD = command instruction splitted in an array
CMD ["python", "manage.py", "runserver", "127.0.0.1:8000"]

# to build adding a tag: docker build -t name:tag .
# to run the build: docker run -p 8000:8000 -d --rm --name django-docker-1 name:tag-build