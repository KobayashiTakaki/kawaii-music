from bs4 import BeautifulSoup as bs
import requests
import os

out_filepath = os.path.dirname(os.path.abspath(__file__)) + '/output.csv'
input_type = input('input type: ')
filename = input('input filename: ')

if input_type == 'html':
    soup = bs(open(filename), 'html.parser')
    links = soup.find_all("a", class_="audibleTile__audibleHeading")
    root_url = "https://soundcloud.com"
    urls = [root_url + link['href'] for link in links]

elif input_type == 'url':
    urls = [line.strip() for line in open(filename).readlines()]

else:
    raise ValueError('invalid input type.')

with open(out_filepath, mode='w', encoding='utf-8') as f:
    for url in urls:
        res = requests.get(url)
        soup = bs(res.content, "lxml")
        page_header_as = soup.find('header').find('h1').find_all('a')
        track_name = page_header_as[0].text
        artist = page_header_as[1].text
        track_id_meta = soup.find('meta', attrs={'property': 'twitter:app:url:iphone'})
        track_id = track_id_meta['content'].split(':')[-1]
        print(','.join([track_id, url, artist, track_name]))
        f.write(','.join([track_id, url, artist, track_name]))
        f.write('\n')
