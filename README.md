# docker

docker-compose with redis php72(phpredis 3.1.3 && composer && ...) mysql 5.6  nginx1.9
also apache with php56

- php版本含5.6 7.2安装了3.1.3的redis拓展,nginx为1.9，均为单独容器，可通过build重新构建
- apache与php56为apache相关，直接使用阿里云仓库，非自建
- 已上传阿里云镜像 地址：registry.cn-qingdao.aliyuncs.com/chs/chlw
