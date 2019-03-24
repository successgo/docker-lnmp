# docker-lnmp

LNMP 代表了 Linux, Nginx, MySQL 和 PHP。

其中 MySQL 可以被 MariaDB 取代。

LNMP 套件组合曾极大的方便了 php 应用的环境布署，时至今日，Docker 出现了，这一组合仍然是流行的。

### 如何使用 docker-lnmp 启动你的 php 应用

利用 docker-compose 工具编排应用（比如你正在参与的 php 应用）依赖的服务时，依赖一个配置文件，通常称之为 `docker-compose.yml`。

```bash
# 复制 docker-compose.yml.dist 为 docker-compose.yml
$ cp docker-compose.yml.dist docker-compose.yml
```

本项目通过配置所有项目所处的路径，以达到配置多项目共用一套 docker-lnmp 环境的便利。

```bash
# 复制 .env.dist 为 .env
$ cp .env.dist .env

# 打开 .env，修改为你的真实的项目所在的路径
$ vim .env
```

docker 启动容器需要先构建镜像，而基础镜像的下载是可以通过配置镜像源来加速下载。镜像加速文档可参考：http://docker-cn.com/registry-mirror

构建 docker 镜像

```bash
# 构建，会自动寻找当前目录下的 docker-compose.yml
$ docker-compose build

# 构建的同时下载最新的基础镜像
$ docker-compose build --pull
```

容器的启动和关闭

```bash
# 启动
$ docker-compose up

# 可通过启用 -d 选项，让其启动完成之后回到命令行，不阻塞命令行
$ docker-compose up -d

# 你还可以启用选项 --build 让启动和构建一同进行
$ docker-compose up --build

# 关闭
docker-compose down
```

用好 docker，你需要了解 docker 命令和 docker-compose 命令，当然还有 docker-compose.yml 文件的编写。

欢迎反馈您的使用感受，可通过 issues 工具。

感谢您使用 docker-lnmp 驱动您的 php 应用。
