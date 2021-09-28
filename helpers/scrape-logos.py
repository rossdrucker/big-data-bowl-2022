"""
@author: Ross Drucker
"""
import os
import urllib

from util import get_soup

def scrape_logos():
    """Scrape ESPN logos for all teams.
    
    These links can be insightful to use in data visualization.
    """

    url = f'https://www.espn.com/nfl/teams'

    soup = get_soup(url)

    links_to_logos = soup.find_all('div', attrs={'class':'ContentList__Item'})

    for link in links_to_logos:
        splitter = 'name/'

        try:
            temp = link.a.get('href')
            s1 = temp.split(splitter)[1]
            s2 = s1.split('/')
            myid = s2[0]
            title = s2[1]

            if title == 'washington':
                title = 'washington-football-team'
        except:
            continue

        base_url = f'https://a.espncdn.com/combiner/i?img=/i/teamlogos/nfl'
        url = f'{base_url}/500/{myid}.png'
        
        try:
            urllib.request.urlretrieve(url, f'img/team-logos/{title}.png')
            print(f'{title.upper().replace("-", " ")} LOGO SUCCESSFULLY '
                  'DOWNLOADED')

        except:
            continue

    return None

if __name__ == '__main__':
    scrape_logos()
