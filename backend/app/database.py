import os

from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# if DATABASE_URL is set in .env, use it for MySQL connection
if os.getenv("ENVIRONMENT") == "production":
    kv_client = SecretClient(
        vault_url=os.getenv("AZURE_KEYVAULT_RESOURCEENDPOINT"),
        credential=DefaultAzureCredential(managed_identity_client_id=os.getenv("AZURE_MANAGED_IDENTITY_CLIENT_ID")),
    )
    DATABASE_URL = kv_client.get_secret("db-connection-string").value
    engine = create_engine(DATABASE_URL)
else:
    DATABASE_URL = "sqlite:///./test.db"
    engine = create_engine(DATABASE_URL)


SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
print("Database module connected")
