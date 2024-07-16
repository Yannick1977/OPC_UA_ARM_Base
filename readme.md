# commande local pour contruire l'image
docker buildx build --platform linux/arm/v7 -t ecn_ua_base --output type=docker .

# save local image to tar fil
docker save --output ecn_ua.tar ecn_ua_base 

# load tar file to ecn card
docker -H 172.16.12.100 load --input ecn_ua.tar

# run the container
docker -H 172.16.12.100 run -d -p 1308:1308 --log-driver json-file --log-opt max-size=10m --log-opt max-file=3 --network="ecn_ecn_apps" --name ecn_ua_test1 ecn_ua_base