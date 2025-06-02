# 1. Base image
FROM python:3.11-slim

# 2. Install uv (so we can create .venv inside container)
RUN pip install uv

# 3. Workdir
WORKDIR /app

# 4. Copy pyproject.toml and uv.lock
COPY pyproject.toml ./

# 5. Create and activate .venv, then sync dependencies
RUN uv lock && uv sync

# 6. Copy app code
COPY main.py ./
# at /app in container
ENV PATH="/app/.venv/bin:${PATH}"


# 7. Expose and run
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

#source .venv/bin/activate
#uv run uvicorn main:app