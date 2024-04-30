from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


# (SQLALCHEMY) Model for thoughts table
class Thought(Base):
    __tablename__ = "thoughts"

    id = Column(Integer, primary_key=True, index=True)
    thought = Column(String(255), index=True)
