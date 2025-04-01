{%- macro state_name_to_code(state_name) -%}

{%- set state_code = {
    "alabama": "AL",
    "alaska": "AK",
    "arizona": "AZ",
    "arkansas": "AR",
    "california": "CA",
    "canal zone": "CZ",
    "colorado": "CO",
    "connecticut": "CT",
    "delaware": "DE",
    "district of columbia": "DC",
    "florida": "FL",
    "georgia": "GA",
    "guam": "GU",
    "hawaii": "HI",
    "idaho": "ID",
    "illinois": "IL",
    "indiana": "IN",
    "iowa": "IA",
    "kansas": "KS",
    "kentucky": "KY",
    "louisiana": "LA",
    "maine": "ME",
    "maryland": "MD",
    "massachusetts": "MA",
    "michigan": "MI",
    "minnesota": "MN",
    "mississippi": "MS",
    "missouri": "MO",
    "montana": "MT",
    "nebraska": "NE",
    "nevada": "NV",
    "new hampshire": "NH",
    "new jersey": "NJ",
    "new mexico": "NM",
    "new york": "NY",
    "north carolina": "NC",
    "north dakota": "ND",
    "ohio": "OH",
    "oklahoma": "OK",
    "oregon": "OR",
    "pennsylvania": "PA",
    "puerto rico": "PR",
    "rhode island": "RI",
    "south carolina": "SC",
    "south dakota": "SD",
    "tennessee": "TN",
    "texas": "TX",
    "unknown": "UN",
    "utah": "UT",
    "vermont": "VT",
    "virgin islands": "VI",
    "virginia": "VA",
    "washington": "WA",
    "washington, d.c.": "DC",
    "washington, district of columbia": "DC",
    "west virginia": "WV",
    "wisconsin": "WI",
    "wyoming": "WY"
} %}

CASE 
    {% for state_full, state_abbr in state_code.items() %}
    WHEN LOWER(TRIM({{ state_name }})) = '{{ state_full }}' THEN '{{ state_abbr }}'
    {% endfor %}
    ELSE 'UN'
END
  
{%- endmacro -%}