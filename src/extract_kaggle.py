from pathlib import Path

import kagglehub
import pandas as pd


def extract_data_from_kaggle(dataset_name: str) -> pd.DataFrame:
    """
    Download a Kaggle dataset using kagglehub and load the first CSV file found.
    """

    dataset_path = kagglehub.dataset_download(dataset_name)
    dataset_path = Path(dataset_path)

    csv_files = list(dataset_path.glob("*.csv"))

    if not csv_files:
        raise FileNotFoundError(
            f"No CSV files found in downloaded dataset: {dataset_path}"
        )

    csv_file = csv_files[0]

    print(f"Dataset downloaded to: {dataset_path}")
    print(f"CSV file selected: {csv_file.name}")

    df = pd.read_csv(csv_file)

    return df


if __name__ == "__main__":
    df = extract_data_from_kaggle("rivalytics/er-wait-time")

    print(df.head())
    print("\nShape:")
    print(df.shape)