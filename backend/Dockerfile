FROM python:3.10-slim
WORKDIR /code
COPY poetry.lock pyproject.toml /code/
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
COPY . /code/
EXPOSE 8000
CMD ["gunicorn", "--config", "app/gunicorn.py","app.main:app"]