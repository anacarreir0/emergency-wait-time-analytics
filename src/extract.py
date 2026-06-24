import pandas as pd
from pathlib import Path


def extract_data(file_path: str) -> pd.DataFrame:
    """
    Load the raw emergency department dataset.
    """

    path = Path(file_path)

    if not path.exists():
        raise FileNotFoundError(
            f"Dataset not found: {file_path}"
        )

    df = pd.read_csv(path)

    return df

if __name__ == "__main__":

    df = extract_data(
        "data/raw/er_wait_time.csv"
    )

    print(df.head())

    print("\nShape:")
    print(df.shape)

