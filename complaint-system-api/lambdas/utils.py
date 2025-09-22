# Shared utility functions for Lambda handlers
def validate_input(body):
    return "description" in body and isinstance(body["description"], str) and len(body["description"].strip()) > 0 