#FROM python:3.12.3-slim

#WORKDIR /django-ecommerce

#COPY requirements.txt .

#RUN pip install --no-cache-dir -r requirements.txt

#COPY . .

# Collect static files (frontend assets)
#RUN python manage.py collectstatic --noinput

#EXPOSE 8000

#ENV SECRET_KEY=kobl@t=yw9d*0y%jt2gjnq78=u!z_rrxb&w8e47l!(jz@m79zy
#ENV DEBUG=False
#ENV DB_NAME=your-db-name
#ENV DB_USER=your-db-user-name
#ENV DB_PASSWORD=your-db-password
#ENV DB_HOST=localhost
#ENV STRIPE_LIVE_PUBLIC_KEY=your-live-public-key
#ENV STRIPE_LIVE_SECRET_KEY=your-live-secret-key
#ENV STRIPE_TEST_PUBLIC_KEY=your-test-public-key
#ENV  STRIPE_TEST_SECRET_KEY=your-test-secret-key
#
#CMD ["gunicorn", "--bind", "0.0.0.0:8000", "ecommerce.wsgi:application"]

#FROM python:3.12.3-slim

#WORKDIR /django-ecommerce

# First, let's verify pip is working
#RUN python -m pip --version

# Create a simple requirements.txt if missing
#RUN echo "Django==4.2.7" > requirements.txt
#
# Install dependencies
#RUN python -m pip install --no-cache-dir -r requirements.txt
#
#COPY . .
#
#EXPOSE 8000
#
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.12.3-slim

WORKDIR /django-ecommerce

# Install system dependencies for Pillow and other packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    python3-dev \
    libpq-dev \
    libjpeg-dev \
    libwebp-dev \
    zlib1g-dev \
    libtiff5-dev \
    libopenjp2-7-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip first
RUN python -m pip install --upgrade pip

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN python -m pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
