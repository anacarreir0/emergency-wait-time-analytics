from extract import extract_data
from transform import transform_data
from load import load_to_postgres


if __name__ == "__main__":

    df = extract_data(
        "data/raw/er_wait_time.csv"
    )

    df_transformed = transform_data(df)

    df_transformed.to_csv(
        "data/processed/er_wait_time_transformed.csv",
        index=False
    )

    print(
        "\nTransformed dataset saved to:"
        "\ndata/processed/er_wait_time_transformed.csv"
    )

    load_to_postgres(
        df=df_transformed,
        table_name="emergency_analytics_transformed"
     
    )