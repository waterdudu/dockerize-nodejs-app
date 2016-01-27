

# Dockerizing a Node.js web app




### 准备 node app
使用 express 创建 node 应用

package.json

```js
{
  "name": "docker-centos-hello",
  "private": true,
  "version": "0.0.1",
  "description": "Node.js Hello world app on CentOS using docker",
  "author": "Daniel Gasienica <daniel@gasienica.ch>",
  "dependencies": {
    "express": "3.2.4"
  }
}
```


index.js

```js
var express = require('express');

// Constants
var PORT = 8080;

// App
var app = express();
app.get('/', function (req, res) {
  res.send('Hello world\n');
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
```


创建 Dockerfile

```bash
# This dockerfile uses the ubuntu image
# VERSION 2 - EDITION 1
FROM centos:centos6

MAINTAINER dudu fianceeyi@@email.com

RUN yum install -y epel-release
RUN yum install -y nodejs npm

COPY package.json /src/package.json
RUN cd /src; npm install

copy ./src /src

EXPOSE 8080

CMD ["node", "/src/index.js"]
```

创建 build docker 脚本 ```build-docker-image.sh```


```bash
#!/bin/bash

docker build -t waterdudu/centos-node-hello .
```


创建 run docker 脚本 ```run-docker.sh```


```bash
#!/bin/bash

docker run -p 49160:8080 -d --name node-docker-app waterdudu/centos-node-hello
```


创建查看 docker logs 脚本 ```show-log-docker.sh```
 
```bash
#!/bin/bash

docker logs $(docker ps -a | grep -v 'CONTAINER' | grep node-docker-app | awk '{print $1}')
```

输出

```
Running on http://localhost:8080
```


发 http 请求访问

先通过 ```docker-machine ip <machine name>```找到 docker machine 的 ip，再通过 ```curl``` 访问

```bash
curl $(docker-machine ip default):49160
```



