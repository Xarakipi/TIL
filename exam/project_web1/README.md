# Project Web1

***

You can test app, before use it in CI/CD

### Host requirements and preparation:

* Installed Docker

* Installed svn

* Installed curl

***

Download project from GitHub

```
svn export https://github.com/Xarakipi/TIL/trunk/exam/project_web1
```

Build docker image

```
sudo docker build -t project_web1 project_web1/
```

Run docker image

```
sudo docker run -d -p 80:80 project_web1
```

Open in your browser http://localhost/
