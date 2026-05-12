import streamlit as st
from openai import OpenAI

st.title("FIFA AI Assistant")

conn = st.connection("snowflake")
client = OpenAI(api_key=st.secrets["openai"]["api_key"])

def generate_sql(question):
    prompt = f"""
Convert the following business question into a Snowflake SQL query.

Table:
FACT_FIFA_FULL

Important columns:
company_name, country, region, tier, age_group, gender,
fifa_total_sales, fifa_units_sold, fifa_operating_profit,
match_day_flag, knockout_stage_flag, fifa_sales_uplift_pct,
campaign_spend, impressions, clicks, conversions,
ctr, conversion_rate, roas, opportunity_score, high_opportunity

Rules:
- DO NOT use markdown
- Return ONLY pure SQL
- Use correct column names
- Use aggregation when needed: SUM, AVG, COUNT
- If ranking companies/countries/regions/customer groups, ALWAYS GROUP BY
- Use LIMIT 10 unless user asks otherwise

Question:
{question}
"""

    response = client.chat.completions.create(
        model="gpt-4.1-mini",
        messages=[{"role": "user", "content": prompt}],
        temperature=0
    )

    sql = response.choices[0].message.content.strip()
    sql = sql.replace("```sql", "").replace("```", "").strip()
    return sql


def explain_result(question, result):
    explanation_prompt = f"""
Explain this business result in simple interview-ready language.

Question:
{question}

Data:
{result.head(10).to_string(index=False)}

Format:
Key Insight:
Business Meaning:
Recommendation:
"""

    response = client.chat.completions.create(
        model="gpt-4.1-mini",
        messages=[{"role": "user", "content": explanation_prompt}],
        temperature=0.3
    )

    return response.choices[0].message.content.strip()


st.subheader("Test Snowflake Connection")

if st.button("Run Test Query"):
    df = conn.query("SELECT COUNT(*) AS total_rows FROM FACT_FIFA_FULL")
    st.write(df)

st.subheader("Ask a question")

question = st.text_input("Type your question")

if st.button("Ask AI"):
    if question:
        sql = generate_sql(question)

        st.subheader("Generated SQL")
        st.code(sql, language="sql")

        try:
            result = conn.query(sql)

            st.subheader("Result")
            st.dataframe(result)

            insight = explain_result(question, result)

            st.subheader("AI Insight")
            st.write(insight)

        except Exception as e:
            st.error(f"Query failed: {e}")