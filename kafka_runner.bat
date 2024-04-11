@echo off

if not exist C:\.kafka (
    md C:\.kafka
    curl.exe --output C:\.kafka\kafka_2.13-3.7.0.tgz --url https://downloads.apache.org/kafka/3.7.0/kafka_2.13-3.7.0.tgz
    tar -xvzf C:\.kafka\kafka_2.13-3.7.0.tgz -C C:\.kafka --strip-components=1
)

if exist C:\.kafka\bin\windows\kafka-server-start.bat (
    echo "starting kafka..."
    start /B C:\.kafka\bin\windows\zookeeper-server-start.bat C:\.kafka\config\zookeeper.properties
    start /B C:\.kafka\bin\windows\kafka-server-start.bat C:\.kafka\config\server.properties
    start /B C:\.kafka\bin\windows\kafka-topics.bat --create --topic test --bootstrap-server localhost:9092
    start /B C:\.kafka\bin\windows\kafka-console-consumer.bat --topic test --from-beginning --bootstrap-server localhost:9092
    echo "done"
) else (
  echo Error downloading and launching kafka :(
  exit
)