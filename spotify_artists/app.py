import requests
import time
import boto3
import json
import logging
import os
import example_response

refreshToken = os.environ['REFRESH_TOKEN']
clientIdClientSecret = os.environ['CLIENT_TOKEN']

logger = logging.getLogger()
logger.setLevel(logging.INFO)

# Connect the DynamoDB database

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('ApotifyApiKeys')


def lambda_handler(event, context):

    logger.info("TestEventReceived")
    return testResponse()

    if 'test' in event['body']:
        logger.info("TestEventReceived")
        return testResponse()

    # See if "expiresAt" indeed indicates we need a new token.
    # Spotify access tokens last for 3600 seconds.
    dbResponse = table.get_item(Key={'spotify': 'prod'})
    expiresAt = dbResponse['Item']['expiresAt']  # In seconds

    # If expired....
    if expiresAt <= time.time():
        refreshTheToken(refreshToken)

    dbResponse = table.get_item(Key={'spotify': 'prod'})
    accessToken = dbResponse['Item']['accessToken']

    headers = {'Authorization': 'Bearer ' + accessToken,
               'Content-Type': 'application/json', 'Accept': 'application/json'}

    response = requests.get(
        'https://api.spotify.com/v1/me/top/artists?limit=5', headers=headers)

    top_5_artists = response.json()

    return {'statusCode': 200, 'body': json.dumps(top_5_artists)}


# Request a new AccessToken from Spotify using the refresh token for our spotifyApp.
# Only called if the current accessToken is expired (on first visit after ~1hr)


def refreshTheToken(refreshToken):

    data = {'grant_type': 'refresh_token', 'refresh_token': refreshToken}

    headers = {'Authorization': "Basic" + clientIdClientSecret}
    p = requests.post('https://accounts.spotify.com/api/token',
                      data=data, headers=headers)

    spotifyToken = p.json()

    # Place the expiration time (current time + almost an hour), and access token into the DB
    table.put_item(Item={'spotify': 'prod', 'expiresAt': int(time.time()) + 3200,
                         'accessToken': spotifyToken['access_token']})


def testResponse():
    return {'statusCode': 200, 'body': json.dumps(example_response.please())}
