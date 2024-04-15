# Start with the base Python container
# FIXME: Update the version
# FROM docker.io/python:PUT-PYTHON-VERSION-HERE
FROM docker.io/python:3.10.13

# Install packages that are required. 
RUN pip install Django==4.2.9 psycopg2

# Install psutil package
RUN pip install psutil

# Copy host Python code into the container
COPY mysite /mysite

# Set environment variables 
ENV PORT=8000 
ENV STUDENT_NAME="John Gray"
ENV SITE_NAME="Fubar Networks"
ENV SECRET_KEY="My_Secret"
ENV DEBUG="1"
# ENV DATA_DIR="/data"

# Note: Remove DATA_DIR and add POSTGRES_* variables
ENV POSTGRES_DB="mysite"
ENV POSTGRES_USER="mysiteuser"
ENV POSTGRES_PASSWORD="this-is-a-bad-password"
ENV POSTGRES_HOSTNAME="localhost"

# Create Database directory
# RUN mkdir ${DATA_DIR}   Not using this anymore

# Set the working directory
WORKDIR /mysite 

# Default command to execute in the container when it starts.
CMD python ./manage.py runserver 0.0.0.0:$PORT
