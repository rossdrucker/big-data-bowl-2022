# [Big Data Bowl 2022](https://www.kaggle.com/c/nfl-big-data-bowl-2022/overview)

## Competition Description (from Kaggle)

Before National Football League (NFL) coaches celebrate a big W, they strategize ways to improve field position and score points. Both of these objectives receive significant contributions from special teams plays, which consist of punts, kickoffs, field goals and extra points. These play types take on important roles in a game’s final score—so much so that coaches say they're a third of the game. Yet special teams remain an understudied part of American football, with an opportunity for data science to offer better ways to understand its impact.

The 2022 Big Data Bowl creates the opportunity for you (and the world!) to learn more about special teams play than ever before. We've provided the NFL's [Next Gen Stats](https://nextgenstats.nfl.com/) (NGS) tracking data from all 2018-2020 special teams plays. This data provides location information for each special teams player, wherever they are on the field, and includes their speed, acceleration, and direction. Additionally, and for the first time in Big Data Bowl history, participants can utilize scouting data from [PFF](https://www.pff.com/), which supplements the tracking data with football specific metrics that coaches find critical to team success.

The NFL is America's most popular sports league. Founded in 1920, the organization behind American football has developed the model for the successful modern sports league. They're committed to advancing every aspect of the game, including the lesser researched special teams. In this competition, you’ll quantify what happens on special teams plays. You might create a new special teams metric, quantify team or individual strategies, rank players, or even something we haven’t considered.

With your creativity and analytical skills, the development of these new methods could lead to additional stats for special teams plays. If successful, your effort [may even be adopted by the NFL](https://www.nfl.com/news/next-gen-stats-intro-to-expected-rushing-yards) for on air distribution, and you can watch future games knowing you had a hand in improving America's most popular sports league.

## Getting Started

### Connect to the Kaggle API

Before downloading the data, it's important to connect to the Kaggle API. First, be sure to have an installation of Python present on the machine (I use 3.9.6 on my machine). Install the Kaggle package from `pip` in your terminal:

```shell
pip install kaggle
````

Once this is installed, log into your [Kaggle](www.kaggle.com) profile. Click on the profile picture in the top left corner, and select `My Account`. Under this section, click `Create new API Token`. This should download a `.json` file called `kaggle.json`. Save it in a known place on your computer (e.g. the `~/Downloads/` directory), then run the following commands in your terminal:

```shell
# Create the .kaggle directory (if it doesn't already exist)
mkdir ~/.kaggle

# Move the downloaded file to the .kaggle directory
mv <location>/kaggle.json ~/.kaggle/kaggle.json

# Give the file proper permissions
chmod 600 ~/.kaggle/kaggle.json
```

If the command

```shell
kaggle competitions list
```

produces output, then this is set up correctly.

### Accessing Data for Competition

From the root directory, run the following command inside a command prompt/terminal:

```shell
sh shell-scripts/00-download-and-prep-data.sh
```

This script calls the scripts in the `shell-scripts` directory, which download the files provided [here](https://www.kaggle.com/c/nfl-big-data-bowl-2022/data), and populates them into a SQLite database. This database, `big-data-bowl-2022.db`, will be housed in the root directory, while the raw download files are stored in the `data-raw/` directory.

## Directory Structure

```big-data-bowl-2022
├── data-raw/                        # Raw data files provided for analysis
│
├── helpers/
│   ├── scrape-logos.py              # Scrape logos from ESPN (populates img/team-logos directory)
│   ├── scrape-wordmarks.py          # Scrape wordmarks from Wikipedia team pages (populates img/team-wordmarks directory)
│
├── img/
│   ├── team-logos/                  # Logo file of each NFL team (from ESPN)
│   ├── team-wordmarks/              # Wordmarks of each NFL team (from Wikipedia)
|   
├── shell-scripts/
│   ├── 00-download-and-prep-data.sh # Call the other scripts in this directory to download data
│   ├── 01-download-data.sh          # Download the data through Kaggle API
│   ├── 02-create-database.sh        # Create the database big-data-bowl-2022.db
│   ├── 03-clean-data.sh             # Clean the raw data files to populate the database
│   ├── 04-populate-database.sh      # Fill the tables of the database with the correct data
│
├── sql-queries/
│   ├── create-tables.sql            # SQL commands to create the database schema
│   ├── populate-database.sql        # sqlite3 commands to read the data from .csv files
│
├── .gitignore                       # Files to ignore when commiting to git repository
├── big-data-bowl-2022.db            # The database created from the files in data-raw/
└── README.md                        # README for repository
```

**Note**: Per the competition's [official rules](https://www.kaggle.com/c/nfl-big-data-bowl-2022/rules), the data cannot be published outside of the competition, and any external data must be made publicly available to all participants. The `data-raw/` directory above contains the publicly available data provided in the competition, as well as a file used to color plots in accordance with team colors.

## Author

[Ross Drucker](mailto:ross.a.drucker@gmail.com)
