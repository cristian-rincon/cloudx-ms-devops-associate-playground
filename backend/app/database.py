import os

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL = "sqlite:///./test.db"

# if DATABASE_URL is set in .env, use it for MySQL connection
if os.getenv("DB_HOST"):
    DATABASE_URL = f"mysql+mysqlconnector://{os.getenv('DB_USERNAME')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
    SSL_ARGS = {
        "ssl_ca": "./DigiCertGlobalRootG2.crt.pem"
    }

    engine = create_engine(DATABASE_URL, 
                           connect_args=SSL_ARGS)
else:
    engine = create_engine(DATABASE_URL)


SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
print("Database module connected")
