from fastapi import FastAPI, HTTPException
from sqlalchemy import create_engine, Table, Column, Integer, String, MetaData, ForeignKey
from sqlalchemy.orm import scoped_session, sessionmaker
from pydantic import BaseModel
import os
from dotenv import load_dotenv

app = FastAPI()

load_dotenv() # take environment variables from .env.

# placeholder used for SQLite connection
DATABASE_URL = 'sqlite:///./test.db'

# use Azure SQL server details from environment variables, if provided
if os.getenv("DB_SERVER") and os.getenv("DB_NAME") and os.getenv("DB_USER") and os.getenv("DB_PASSWORD"):
    server = os.getenv("DB_SERVER", "localhost")
    database = os.getenv("DB_NAME", "test")
    username = os.getenv("DB_USER", "user")
    password = os.getenv("DB_PASSWORD", "password")
    driver= '{ODBC Driver 17 for SQL Server}'
    DATABASE_URL = f"mssql+pyodbc://{username}:{password}@{server}/{database}?driver={driver}"

engine = create_engine(DATABASE_URL)

metadata = MetaData()
global thoughts
thoughts = Table('thoughts', metadata,
                 Column('id', Integer, primary_key=True),
                 Column('thought', String(50))
                 )

metadata.create_all(engine)

Session = scoped_session(sessionmaker(bind=engine))

class ThoughtModel(BaseModel):
    thought: str

@app.post("/thoughts")
async def store_thought(thought: ThoughtModel):
    """Store user thought"""
    session = Session()
    
    try:
        result = session.execute(thoughts.insert().values(thought=thought.thought))
        session.commit()
        return {"message": "Thought stored successfully"}
    except Exception as e:
        session.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        session.close()


@app.get("/thoughts")
async def get_thoughts():
    """Get all thoughts"""
    session = Session()

    try:
        thought_query = session.execute(thoughts.select())
        all_thoughts = [{'id': row[0], 'thought': row[1]} for row in thought_query.fetchall()]
        return all_thoughts
    except Exception as e:
        session.rollback()
        raise HTTPException(status_code=400, detail=str(e))
    finally:
        session.close()


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=8000)