import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql://analyst:analyst@postgres:5432/irembo"
)

files = {
    "users": "data/raw/users.csv",
    "voice_sessions": "data/raw/voice_sessions.csv",
    "voice_turns": "data/raw/voice_turns.csv",
    "voice_ai_metrics": "data/raw/voice_ai_metrics.csv",
    "applications": "data/raw/applications.csv",
}

for table, path in files.items():
    df = pd.read_csv(path)
    df.to_sql(table, engine, if_exists="replace", index=False)

print("Data loaded successfully")
