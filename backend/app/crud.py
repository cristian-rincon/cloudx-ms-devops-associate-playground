from sqlalchemy.orm import Session

from app import models, schemas


def save_thought(session: Session, thought: schemas.ThoughtModel):
    """Store user thought"""
    thought_db = models.Thought(thought=thought.thought)
    session.add(thought_db)
    session.commit()
    return thought_db


def retrieve_thoughts(session: Session):
    """Get all thoughts"""
    return session.query(models.Thought).all()
