#!/bin/bash
pip install -r requirements.txt
python -m gunicorn app:app --bind 0.0.0.0:$PORT 