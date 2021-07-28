
1. Install last [docker engine](https://docs.docker.com/engine/install/) for your local PC
2. If you want to run your docker without sudo, add next command

> sudo usermod -aG docker $USER

3. Create folder:

> mkdir dockerTest

4. Go to this folder

> cd dockerTest

5. Create Dockerfile

> touch Dockerfile

6. Change this file (nano Dockerfile)

>FROM ubuntu:18.04
>
>RUN apt-get -y update
>
>RUN apt-get -y install apache2
>
>RUN echo 'Docker App1 <b>v2.0</b1>' > /var/www/html/index.html
>
>CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
>
>EXPOSE 80

7. If you want use last version of Ubuntu,  you mast add time zone in Dockerfile

>FROM ubuntu:latest
>
>ENV TZ=Etc/UTC
> 
>RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
>
>RUN apt-get -y update
> 
>RUN apt-get -y install apache2
>
>RUN echo 'Docker App1 <b>v1.0</b1>' > /var/www/html/index.html
>
>CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
> 
>EXPOSE 80

8. Create your docker image
> docker build -t app1:v1 .

9. Create credentials 
> aws ecr get-login --no-include-email --region=ca-central-1

10. Copy and enter this cred

11. Change name of our docker images

> docker tag app1:v1 Copy_Name_Of_aws_Repository_Name:v1

12. Push your docker to aws

>docker push Copy_Name_Of_aws_Repository_Name:v1

13. How to delete this images

> docker rmi ID_DOCKER_1 ID_DOCKER_2 -f

14. How to pull docker images from aws

> docker pull AWS_NAME_COPY_app:YOUR_VERSION
