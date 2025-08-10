FROM python:3.10-slim

ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=config.settings.production

# Install OS deps
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libmagic1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# No collectstatic here — we'll run it in CMD
CMD python manage.py migrate && \
    python manage.py collectstatic --noinput && \
    gunicorn config.wsgi:application --bind 0.0.0.0:8000
