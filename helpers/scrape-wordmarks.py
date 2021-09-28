"""Download team wordmark SVGs from Wikipedia.

@author: Ross Drucker
"""
import os
import time
import urllib
import requests
from bs4 import BeautifulSoup

teams = [
    'Arizona Cardinals',
    'Atlanta Falcons',
    'Baltimore Ravens',
    'Buffalo Bills',
    'Carolina Panthers',
    'Chicago Bears',
    'Cincinnati Bengals',
    'Cleveland Browns',
    'Dallas Cowboys',
    'Denver Broncos',
    'Detroit Lions',
    'Green Bay Packers',
    'Houston Texans',
    'Indianapolis Colts',
    'Jacksonville Jaguars',
    'Kansas City Chiefs',
    'Las Vegas Raiders',
    'Los Angeles Chargers',
    'Los Angeles Rams',
    'Miami Dolphins',
    'Minnesota Vikings',
    'New England Patriots',
    'New Orleans Saints',
    'New York Giants',
    'New York Jets',
    'Philadelphia Eagles',
    'Pittsburgh Steelers',
    'San Francisco 49ers',
    'Seattle Seahawks',
    'Tampa Bay Buccaneers',
    'Tennessee Titans',
    'Washington Football Team'
]

base_url = 'https://commons.wikimedia.org/wiki/File:'

for team in teams:
    team_underscore = team.replace(' ', '_')
    team_hyph = team.replace(' ', '-')
    url = f'{base_url}{team_underscore}_wordmark.svg'

    if team == 'Dallas Cowboys':
        url = f'{base_url}Cowboys_wordmark.svg'

    if team == 'Pittsburgh Steelers':
        url = f'{base_url}Pittsburgh_Steelers_Script.svg'

    if team == 'Washington Football Team':
        wordmark_url = ('https://www.washingtonjourney.com/wp-content/themes/'
                        'united/img/washington.svg')

        os.system(f'wget -O img/team-wordmarks/wft.svg {wordmark_url}')

        continue

    response = requests.get(url)

    if response.status_code == 200:
        valid_link = True

    else:
        valid_link = False

    if valid_link:
        soup = BeautifulSoup(response.text, 'html.parser')

        wordmark_url = soup.find_all('a', attrs = {'class': 'internal'})
        wordmark_url = wordmark_url[0].get('href')

        urllib.request.urlretrieve(
            wordmark_url,
            f'img/team-wordmarks/{team_hyph.lower()}.svg'
        )

        print(f'{team.upper()} WORDMARK SUCCESSFULLY DOWNLOADED')

    else:
        print(f'Cannot get wordmark for {team}\n')

    time.sleep(5)
