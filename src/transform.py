import pandas as pd


def clean_column_names(df: pd.DataFrame) -> pd.DataFrame:
    """
    Convert column names to snake_case.
    Example:
    'Patient Satisfaction' -> 'patient_satisfaction'
    """

    df = df.copy()

    df.columns = (
        df.columns
        .str.strip()
        .str.lower()
        .str.replace(" ", "_")
        .str.replace("-", "_")
        .str.replace("(", "", regex=False)
        .str.replace(")", "", regex=False)
    )

    return df


def add_triage_mapping(df: pd.DataFrame) -> pd.DataFrame:
    """
    Map urgency levels to an approximate Manchester Triage model
    and create operational performance indicators.
    """

    df = df.copy()

    # Educational approximation of Manchester triage colours

    triage_colour_mapping = {
        "Critical": "Red",
        "High": "Orange",
        "Medium": "Yellow",
        "Low": "Green"
    }

    # Approximate recommended waiting times (minutes)

    recommended_wait_time_mapping = {
        "Critical": 0,
        "High": 10,
        "Medium": 60,
        "Low": 120
    }

    # Add triage colour

    df["triage_colour"] = (
        df["urgency_level"]
        .map(triage_colour_mapping)
    )

    # Add recommended waiting time

    df["recommended_wait_time_min"] = (
        df["urgency_level"]
        .map(recommended_wait_time_mapping)
    )

       # Time from triage to medical professional
    df["triage_to_medical_professional_min"] = (
        df["time_to_medical_professional_min"]
    )

    # Difference between actual and recommended wait time
    df["wait_time_difference_min"] = (
        df["triage_to_medical_professional_min"]
        - df["recommended_wait_time_min"]
    )
   
    # Compliance with target waiting time

    df["target_compliance"] = (
        df["wait_time_difference_min"]
        .apply(
            lambda x:
            "Compliant"
            if x <= 0
            else "Non-Compliant"
        )
    )

    return df


def transform_data(df: pd.DataFrame) -> pd.DataFrame:
    """
    Apply all transformation steps.
    """

    df = clean_column_names(df)

    # Convert visit_date from text to datetime

    df["visit_date"] = pd.to_datetime(
        df["visit_date"]
    )

    df = add_triage_mapping(df)

    return df