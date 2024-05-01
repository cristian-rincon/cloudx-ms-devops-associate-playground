import os

from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# if DATABASE_URL is set in .env, use it for MySQL connection
if os.getenv("ENVIRONMENT") == "production":
    kv_client = SecretClient(
        vault_url=os.getenv("AZURE_KEYVAULT_RESOURCEENDPOINT"),
        credential=DefaultAzureCredential(),
    )
    db_username = kv_client.get_secret("db-username")
    db_password = kv_client.get_secret("db-password")
    db_host = kv_client.get_secret("db-host")
    db_name = kv_client.get_secret("db-name")
    DATABASE_URL = (
        f"mysql+mysqlconnector://{db_username}:{db_password}@{db_host}/{db_name}"
    )
    engine = create_engine(DATABASE_URL)
else:
    DATABASE_URL = "sqlite:///./test.db"
    engine = create_engine(DATABASE_URL)


SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
print("Database module connected")
