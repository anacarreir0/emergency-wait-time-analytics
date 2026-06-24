def load_to_postgres(
    df: pd.DataFrame,
    table_name: str,
    database_name: str = "emergency_analytics"
) -> None:
    """
    Load a pandas DataFrame into a PostgreSQL table.
    If the table already exists, it will be replaced.
    """

    # Removed database credentials from repository
    engine = create_engine(
        f"postgresql+psycopg2://postgres:YOUR_PASSWORD@localhost/{database_name}"
    )

    df.to_sql(
        name=table_name,
        con=engine,
        if_exists="replace",
        index=False
    )

    print(
        f"\nData loaded successfully into PostgreSQL table: {table_name}"
    )