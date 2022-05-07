echo "STARTING DEPLOYMENT"
container_id_to_be_killed=$(docker ps --format '{{.ID}}')
docker kill ${container_id_to_be_killed}
sleep 10
docker run -d -p 8443:443 -v miq_db:/var/lib/pgsql/data -v miq_certs:/var/www/miq/vmdb/certs manageiq/manageiq:latest
sleep 10
container_id=$(docker ps --format '{{.ID}}')
docker cp css/application-99fc2fa076575c731877cb7b8b51c07116e480eb788398199e8ba4baebff9382.css ${container_id}:/var/www/miq/vmdb/public/assets/
docker cp js/globals-7e22a59ce0c9042897b5.js ${container_id}:/var/www/miq/vmdb/public/packs/manageiq-ui-classic/
docker cp png/bg-modal-about-pf-9d05b59b78514c33d3eca31566cd385266e46c58327a7b6b15806c1190a74676.png ${container_id}:/var/www/miq/vmdb/public/assets/layout/
docker cp png/login-screen-logo-cd43380036fc96964823fd8d6d7486fe9bcfcce1498daf0c41d8bc94385511da.png ${container_id}:/var/www/miq/vmdb/public/assets/layout/
docker cp svg/brand-238fd8d5ec6a8907af00d80292c5a2a1d2becb340930ed421d71605e022c2193.svg ${container_id}:/var/www/miq/vmdb/public/assets/layout
docker cp svg/manageiq-logo-inverse-253f01ae80feb536f281780c0da776842689b695af9657769ca765dcfad95a5b.svg ${container_id}:/var/www/miq/vmdb/public/assets/layout
docker cp locale/en.yml ${container_id}:/var/www/miq/vmdb/locale/
docker cp config/settings.yml  ${container_id}:/var/www/miq/vmdb/config/
docker restart ${container_id}
sleep 300
echo "DEPLOYMENT COMPLETED, KINDLY ACCESS THE ENVIRONMENT AFTER 15 MINUTES"
