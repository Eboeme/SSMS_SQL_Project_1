

# Google Play Store Apps Data Analysis

## About

This project aims to explore data from the Google Play Store apps to derive insights into app popularity, user engagement, and other key metrics. The goal is to understand trends and patterns that influence app performance and user preferences.

## Dataset Information

The dataset includes various attributes of Google Play Store apps:

| Column         | Description                               | Data Type      |
|----------------|-------------------------------------------|----------------|
| App            | Name of the app                            | NVARCHAR(MAX)  |
| Category       | Category of the app                        | NVARCHAR(50)   |
| Rating         | Average user rating                        | NVARCHAR(50)   |
| Reviews        | Number of user reviews                     | INT            |
| Size           | Size of the app                            | NVARCHAR(50)   |
| Installs       | Number of installs                         | NVARCHAR(50)   |
| Type           | Type of the app (Free or Paid)             | NVARCHAR(50)   |
| Price          | Price of the app                           | MONEY          |
| Content_Rating | Content rating                             | NVARCHAR(50)   |
| Genres         | Genres of the app                          | NVARCHAR(50)   |
| Last_Updated   | Date of the last update                    | DATE           |
| Current_Ver    | Current version of the app                 | NVARCHAR(50)   |
| Android_Ver    | Required Android version                   | NVARCHAR(50)   |

## Analysis List

### Basic Analysis

1. **Apps with the most reviews**
2. **Apps with the largest number of installs**
3. **Average rating, size, and number of reviews of the apps**
4. **Maximum and minimum number of installs**
5. **Count of apps by category**
6. **Total count of apps by content rating**

### Specific Analysis

1. **Free apps with more than 1,000,000 installs**
2. **Details of apps in the "ART_AND_DESIGN" category**
3. **Top 5 apps with the most reviews in the "GAME" category**
4. **Average rating of free vs. paid apps**
5. **Apps in the "FAMILY" category with the highest rating**
6. **Top 5 most recent apps in the "SOCIAL" category**
7. **Apps with a size greater than 50MB and more than 1,000,000 installs**

### Advanced Analysis

1. **Top 10 apps with the highest rating and their corresponding number of reviews**
2. **List of apps that are paid**
3. **Apps with size between 20MB and 50MB and rating above 4.0**
4. **Apps sorted by their number of reviews (descending order)**
5. **Count of apps by their rating ranges**
6. **Comparison of the average rating, size, and number of reviews between different content ratings**
