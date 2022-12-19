FROM python:slim as requirements-stage

WORKDIR /tmp
RUN pip install poetry
COPY ./pyproject.toml /tmp/
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes


FROM hexaforce/fastapi-docker
COPY --from=requirements-stage /tmp/requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY ./app /app