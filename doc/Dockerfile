# 基础镜像
FROM usedtolove/jre8

# 卷
VOLUME /tmp

# copy file
ADD tlhhup-1.0-SNAPSHOT.jar app.jar

# 记录服务可用的端口
EXPOSE 10010

#ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
# 远程调试
CMD ["java","-jar","-Djava.security.egd=file:/dev/./urandom","app.jar"]