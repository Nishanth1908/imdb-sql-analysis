# Understanding Audience Reception Through IMDb Data
### An SQL Case Study Using the IMDb Dataset

---

## Why This Project?

As someone interested in both data analytics and the entertainment industry, I wanted to explore whether a large, real-world dataset like IMDb could reveal meaningful patterns about movie audience reception.

Rather than treating this as a SQL practice exercise, I wanted to investigate questions that could be relevant to content recommendation and acquisition decisions. Using SQL, I analyzed factors such as audience ratings, engagement, runtime, genre, release period, and directors to identify patterns associated with positively recieved movies.

---

## Problem in Focus

Streaming platforms and digital content providers invest significant resources in acquiring and recommending movies that will resonate with audiences. While many factors influence these decisions, understanding how characteristics such as genre, runtime, release period, and audience engagement relate to movie success can provide valuable insights.

This project explores whether publicly available IMDb data can be used to identify patterns associated with highly successful movies. The goal is not to predict success, but to examine which characteristics consistently appear among movies that receive strong audience ratings and engagement.

---

## Evaluation Metrics

For the purpose of this analysis, good movie reception is evaluated using two publicly available IMDb metrics:

- **Average Rating** – reflects overall audience satisfaction.
- **Number of Votes** – serves as a proxy for audience engagement and popularity.

Although these metrics do not measure commercial success directly, they provide useful indicators of audience reception. 

---

## Questions Answered

1. Which characteristics are commonly associated with highly rated movies?
2. Does runtime influence audience ratings or engagement?
3. Which genres combinations consistently perform well?
4. How have audience preferences changed across different decades?
5. Which directors have the strongest track record based on IMDb ratings?
6. What insights from this analysis could support content recommendation or acquisition decisions?

---

## Methodology

This project followed a structured analytical workflow to investigate factors associated with positive audience reception using the IMDb dataset.

---

### Workflow 

IMDb Dataset
      │
      ▼
Data Import
      │
      ▼
Data Preparation
      │
      ▼
SQL Analysis
      │
      ▼
  Insights
      │
      ▼
Recommendations

### 1. Data Collection
- Downloaded the publicly available IMDb non-commercial datasets.
- Selected the relevant tables:
  - `title_basics`
  - `title_ratings`
  - `title_crew`
  - `name_basics`

### 2. Data Preparation
- Imported the datasets into MySQL.
- Created indexes on key coloums to improve query performance during joins and analysis.
- Joined the relevant tables to construct a consolidated `movies` table for analysis.
- Removed records with missing or invalid values where necessary.

### 3. Defining Metrics
Audience reception was evaluated using:
- **Average IMDb Rating** as a measure of audience satisfaction.
- **Number of IMDb Votes** as a proxy for audience engagement.

### 4. Exploratory Analysis
SQL queries were used to explore patterns in:
- Rating distributions
- Runtime patterns
- Genre performance
- Release decade trends
- Director performance
- Audience engagement

### 5. Analysis
Each query was designed to answer a specific business question related to audience reception rather than simply describing the dataset.

### 6. Interpretation
The findings were translated into actionable insights and recommendations while acknowledging the limitations of relying solely on IMDb ratings and audience votes.

---

## Analysis

The analysis was conducted to answer the business questions outlined earlier.

### 1. Characteristics of Highly Rated Movies

**Question Addressed**
Which characteristics are commonly associated with highly rated movies?

**Approach**
The analysis explored the relationship between runtime, genre combinations, release decade, and audience engagement to identify characteristics commonly associated with highly rated movies.

**Key Observations**

- Movies between **120–179 minutes** generally received **higher average IMDb ratings** and stronger audience engagement than shorter movies.
- Audience **reception remained relatively consistent across decades**, indicating that highly rated movies are not confined to a particular era.
- **Documentary and drama based genre combinations** achieved the **highest average IMDb ratings**, while horror based combinations generally received lower ratings.
- IMDb ratings and vote counts measured different aspects of audience reception, as highly rated genre combinations did not always attract the highest audience engagement.

### 2. Runtime and Audience Engagement

**Question Addressed**
Does runtime influence audience ratings or engagement?

**Approach**
Movies were grouped into runtime categories to compare the proportion of highly rated movies (IMDb rating ≥ 8) and evaluate how runtime influences audience reception.

**Key Observations**
- The likelihood of achieving an IMDb rating of **8 or above** generally increased with runtime.
- Movies running **150 minutes or longer** had a higher proportion of highly rated titles than standard-length movies.
- Although **180+ minute** movies recorded the highest success rate, they represented a relatively small portion of the dataset.

### 3. Genre Performance

**Question Addressed**
Which genres consistently perform well?

**Approach**
Individual genres were compared using average IMDb ratings, audience engagement (number of votes), and the number of movies to identify genres that consistently perform well.

**Key Observations**
- Documentary-related genres achieved the highest average IMDb ratings.
- Drama combined strong audience ratings with the largest number of movies, indicating consistent performance across a substantial sample.
- Sci-Fi attracted the highest audience engagement despite having only moderate average ratings.
- Horror recorded the lowest average IMDb rating among the major genres.

### 4. Audience Preferences Over Decades

**Question Addressed**
How have audience preferences changed across different decades?

**Approach**
Two analyses were performed. First, the most common genre in each decade was identified to understand production trends. Second, genres with at least 1,000 IMDb votes per movie were compared to determine the highest-rated genre in each decade, providing a more reliable measure of audience preference.

**Key Observations**
- Drama remained the most commonly produced genre from the 1910s onward, indicating its long-standing dominance in film production.
- The highest-rated genre changed across decades, suggesting that audience preferences evolved over time rather than remaining fixed.
- Documentary emerged as the highest-rated genre from the 1960s onward in most decades, demonstrating consistently strong audience reception.
- Earlier decades were led by a wider variety of genres—including Drama, Horror, Thriller, Family, and War—before Documentary became the most consistently highly rated genre.

### 5. Director Performance

**Question Addressed**
Which directors have the strongest track record based on IMDb ratings?

**Approach**
Movies with at least **1,000 IMDb votes** were grouped by director to ensure reliable audience ratings. Directors with fewer than **five qualifying movies** were excluded to focus on sustained performance. Directors were ranked by their average IMDb rating, with total audience votes used as a tie-breaker.

**Key Observations**
- Several directors consistently achieved average IMDb ratings above **8.0** across multiple films, demonstrating sustained quality rather than isolated successes.
- Christopher Nolan combined high average ratings with exceptionally large audience engagement, indicating both critical acclaim and widespread popularity.
- Directors such as **Satyajit Ray, Hayao Miyazaki, Quentin Tarantino,** and **Sergio Leone** maintained high average ratings across multiple films, demonstrating long-term consistency.
- Some directors achieved exceptionally high average ratings but attracted comparatively smaller audiences, highlighting that critical reception and audience reach do not always align.
- Comparing these findings with earlier analyses suggests that many successful directors frequently produce films in well-performing genres like drama and documentaries with runtimes commonly associated with higher audience ratings.

---

## Recommendations
Based on the findings of this analysis, the following recommendations may support content recommendation and acquisition decisions.

### 1. Prioritize Drama for Broad Audience Appeal
Drama consistently demonstrated strong audience reception while also representing the largest volume of highly rated movies (see [Genre Performance](#3-genre-performance) and [Audience Preferences Over Decades](#4-audience-preferences-over-decades)). This makes it a reliable category for both content acquisition and recommendation.

### 2. Expand Critically Acclaimed Documentary Content
Documentary-related genres achieved the highest average IMDb ratings and remained among the highest-rated genres across multiple decades (see [Characteristics of Highly Rated Movies](#1-characteristics-of-highly-rated-movies), [Genre Performance](#3-genre-performance), and [Audience Preferences Over Decades](#4-audience-preferences-over-decades)). These findings suggest that documentaries can strengthen a catalogue focused on critically acclaimed content.

### 3. Consider Runtime as a Supporting Evaluation Metric
Movies between **120 and 179 minutes** consistently received stronger audience ratings and were more likely to achieve IMDb ratings of **8 or above** (see [Characteristics of Highly Rated Movies](#1-characteristics-of-highly-rated-movies) and [Runtime and Audience Engagement](#2-runtime-and-audience-engagement)). While runtime should not be treated as a predictor of success, it can serve as a useful supporting criterion alongside other evaluation metrics.

### 4. Evaluate Both Ratings and Audience Engagement
Average IMDb ratings and vote counts captured different aspects of audience reception throughout the analysis (see [Characteristics of Highly Rated Movies](#1-characteristics-of-highly-rated-movies), [Genre Performance](#3-genre-performance), and [Director Performance](#5-director-performance)). Evaluating both metrics together provides a more balanced assessment than relying on either measure alone.

### 5. Consider Director Track Record During Content Acquisition
Several directors consistently maintained high IMDb ratings across multiple films, while directors such as Christopher Nolan also demonstrated exceptionally strong audience engagement (see [Director Performance](#5-director-performance)). A director's historical track record can therefore serve as a valuable indicator when evaluating potential acquisitions, particularly when combined with genre performance and audience engagement metrics.

---

## Key Findings
The analysis identified several recurring patterns associated with positive audience reception on IMDb:

- Movies with runtimes between **120 and 179 minutes** consistently received stronger audience ratings and had a higher likelihood of achieving IMDb ratings of **8 or above** (see [Characteristics of Highly Rated Movies](#1-characteristics-of-highly-rated-movies) and [Runtime and Audience Engagement](#2-runtime-and-audience-engagement)).

- **Drama** demonstrated the most consistent audience appeal across the dataset, while **Documentary** genres achieved the highest average IMDb ratings, highlighting the difference between broad popularity and critical appreciation (see [Genre Performance](#3-genre-performance)).

- Audience preferences evolved across decades, with different genres emerging as the highest rated over time. However, Drama remained the dominant genre in terms of production, indicating its long-standing commercial importance (see [Audience Preferences Over Decades](#4-audience-preferences-over-decades)).

- Several directors consistently maintained high IMDb ratings across multiple films, while directors such as Christopher Nolan also attracted exceptionally large audiences, demonstrating that sustained quality and widespread popularity can coexist (see [Director Performance](#5-director-performance)).

- IMDb **average rating** and **number of votes** measured complementary aspects of audience reception. Evaluating both metrics together provided a more comprehensive assessment of movie performance than relying on either metric alone (see [Characteristics of Highly Rated Movies](#1-characteristics-of-highly-rated-movies), [Genre Performance](#3-genre-performance), and [Director Performance](#5-director-performance)).

---

## Limitations
The findings presented in this project should be interpreted in the context of the following limitations:

- **IMDb ratings and vote counts were used as proxies for audience reception.** While these metrics reflect user opinions and engagement, they do not directly measure commercial success, profitability, or viewer retention.

- **The analysis identifies associations rather than causal relationships.** For example, while longer movies were more likely to receive higher ratings, the analysis does not imply that increasing a movie's runtime causes better audience reception.

- **Several important business variables were not included.** Factors such as production budget, box office revenue, marketing expenditure, streaming viewership, critic reviews, cast, release strategy, and awards may also influence audience reception.

- **Audience preferences may be affected by demographic and regional differences.** IMDb represents a global user base, but the analysis does not account for variations across countries, cultures, or audience segments.

- **The study is limited to the publicly available IMDb dataset.** Consequently, the recommendations should be considered as data-informed insights rather than definitive business rules and are best used alongside additional market and commercial data.

---

## Future Work
This project provides an exploratory analysis of audience reception using SQL and publicly available IMDb data. Future work could extend the analysis in several ways:

- **Incorporate commercial performance metrics** such as box office revenue, production budget, and return on investment (ROI) to examine how audience reception relates to financial success.

- **Integrate additional data sources**, including critic ratings (e.g., Rotten Tomatoes or Metacritic), streaming viewership, and award nominations, to develop a more comprehensive measure of movie performance.

- **Explore the influence of other creative factors**, such as actors, writers, production companies, and franchises, to better understand the drivers of audience reception.

- **Develop predictive models** using Python and machine learning techniques to estimate audience ratings or engagement based on movie characteristics.

- **Build an interactive dashboard** using Power BI or Tableau to enable dynamic exploration of trends across genres, directors, runtimes, and release periods.




