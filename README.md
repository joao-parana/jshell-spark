# JShell with Java 9 and Spark

Comandos no Terminal

    mvn install && mvn assembly:single  
    export MYSQL_PORT_3306_TCP_ADDR=dockerhost.local
    # Parando e removendo o contêiner MySQL caso já exista
    docker stop mysql_db ; docker rm  mysql_db
    export MYSQL_ROOT_PASSWORD=xpto
    docker run -d --name mysql_db -p 3306:3306 \
           -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
           -e MYSQL_DATABASE=test \
           -e MYSQL_USER=test \
           -e MYSQL_PASSWORD=test \
           mariadb
    mysql -u root -h dockerhost.local -p # Informar senha xpto
    mysql> show databases;
    mysql> use test;
    mysql> show tables; 
    java -jar target/myJshellAppLib.jar

Rodando com JShell no conteiner

    ./build-jshell-spark
    docker run -i -t --rm --name spark-j9 \
           --link mysql_db:mysql \
           parana/jshell-spark bash

    # Testando o JShell
    jshell
    /classpath target/myJshellAppLib.jar 
    import br.com.joaoparana.*
    App app = new App()
    String[] args = { "HELP" }
    App.main(args)
    
    long fibonacci(int n) {

      if (n < 2) {
        return n;
      }
      return fibonacci(n-1) + fibonacci(n-2);
    }
    import java.util.stream.*
    Stream.of(20,30,40,50).map(i -> fibonacci(i)).forEach(System.out::println)

