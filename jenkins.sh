cd /home/ubuntu/repository

if [ -d "/home/ubuntu/repository/ezops-test-carlos" ]
then
rm -rf ezops-test-carlos
git clone https://github.com/carloseduardocruz/ezops-test-carlos.git
else
git clone https://github.com/carloseduardocruz/ezops-test-carlos.git
fi

cd ezops-test-carlos

dockerups=`docker ps -a -q`

if [ "$dockerups" != "" ]
then
docker stop $dockerups
docker rm $dockerups
fi

dockerimages=`docker images -q`
if [ "$dockerimages" != "" ]
then
docker rmi $dockerimages
fi

docker system prune -f

docker images
docker ps -a

git checkout feature/app

docker build -t carlos/app-web:$BUILD_NUMBER .
docker run -p 80:80 -d carlos/app-web:$BUILD_NUMBER
