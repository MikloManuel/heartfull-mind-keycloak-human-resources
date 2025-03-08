#!/bin/bash
java -Djava.util.concurrent.ForkJoinPool.common.threadFactory=io.quarkus.runtime.ThreadPoolManager\$QuarkusForkJoinWorkerThreadFactory \
     -jar quarkus/server/target/lib/quarkus-run.jar \
     start-dev \
     --db=postgres \
     --db-url=jdbc:postgresql://localhost:5432/heartfullmind \
     --db-username=heartfullmind \
     --db-password=ihMMuka8212Neuhausen
