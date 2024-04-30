from pydantic import BaseModel


# Pydantic model for thoughts table
class ThoughtModel(BaseModel):
    thought: str
