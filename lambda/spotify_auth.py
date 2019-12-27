# Only called if the current accessToken is expired (on first visit after ~1hr)


def refreshTheToken(refreshToken):

    clientIdClientSecret = 'Basic <YOUR BASE-64d APP TOKEN>'
    data = {'grant_type': 'refresh_token', 'refresh_token': refreshToken}

    headers = {'Authorization': clientIdClientSecret}
    p = requests.post('https://accounts.spotify.com/api/token',
                      data=data, headers=headers)

    spotifyToken = p.json()

    # Place the expiration time (current time + almost an hour), and access token into the DB
    table.put_item(Item={'spotify': 'prod', 'expiresAt': int(time.time()) + 3200,
                         'accessToken': spotifyToken['access_token']})
