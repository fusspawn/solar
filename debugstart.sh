dir;
dir ./web/server/client/;
./dart-sdk/bin/dart2js -o web/server/client/bundle.js web/server/client/networkedsolarclient.dart
echo "compiled client to js";

./dart-sdk/bin/dart web/server/solarserver.dart