
import os
from dotenv import load_dotenv
from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy.orm import Session
from fastapi.middleware.cors import CORSMiddleware

from app.crud import retrieve_thoughts, save_thought
from app.database import SessionLocal, engine
from app.models import Base
from app.schemas import ThoughtModel

load_dotenv(dotenv_path=os.path.join(os.getcwd(),"app/.env")) 

Base.metadata.create_all(bind=engine)

app = FastAPI()

# CORS
origins = [
    "http://localhost",
    "http://localhost:5173",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# placeholder used for SQLite connection


@app.post("/thoughts", response_model=ThoughtModel)
async def store_thought(thought: ThoughtModel, db: Session = Depends(get_db)):
    """Store user thought"""
    return save_thought(db, thought)


@app.get("/thoughts")
async def get_thoughts(db: Session = Depends(get_db)):
    """Get all thoughts"""
    return retrieve_thoughts(db)


# if __name__ == "__main__":
#     import uvicorn

#     uvicorn.run(app, host="localhost", port=8000)
