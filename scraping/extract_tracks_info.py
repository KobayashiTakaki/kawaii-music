from bs4 import BeautifulSoup as bs
import requests

filename = input('input filename: ')
soup = bs(open(filename), 'html.parser')

links = soup.find_all("a", class_="audibleTile__audibleHeading")

hostname = "https://soundcloud.com"

for link in links:
    url = hostname + link['href']
    res = requests.get(url)
    res.encoding = res.apparent_encoding
    soup = bs(res.text, 'html.parser')
    page_header_as = soup.find('header').find('h1').find_all('a')
    artist = page_header_as[0].text
    track_name = page_header_as[1].text
    track_id_meta = soup.find('meta', attrs={'property': 'twitter:app:url:iphone'})
    track_id = track_id_meta['content'].split(':')[-1]
    print(', '.join([track_id, url, artist, track_name]))
