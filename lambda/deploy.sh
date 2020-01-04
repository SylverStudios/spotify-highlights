#!/bin/bash
pip install requests --target ./package

FILE="spotify_top_artists"
rm $FILE.zip
cd package
zip -r ../$FILE.zip .
cd ..
zip -g $FILE.zip top_artists.py
zip -g $FILE.zip example_response.py

echo "Zip ready:"
echo $FILE.zip

# aws lambda update-function-code --function-name $NAME --zip-file fileb://$FILE.zip
