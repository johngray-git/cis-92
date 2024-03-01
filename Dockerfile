# Start with the base Python container
# FIXME: Update the version
# FROM docker.io/python:PUT-PYTHON-VERSION-HERE
FROM docker.io/python:3.10.13

# Install packages that are required. 
RUN pip install Django==4.2.9

# Install psutil package
RUN pip install psutil

# Create Database directory
RUN mkdir /data

# Copy the Python code into the container
COPY mysite /mysite

# Set environment variables 
ENV PORT=8000 
ENV STUDENT_NAME="John Gray"
ENV SITE_NAME="Fubar Networks"
ENV SECRET_KEY="My_Secret"
ENV DEBUG="1"
ENV DATA_DIR="/data"

# Set the working directory
WORKDIR /mysite 

# Default command to execute in the container
CMD python ./manage.py runserver 0.0.0.0:$PORT