# Redis Cluster Playground

This is a basic repo with some scripts to speed up setting up a mini redis cluster on your computer so you can mess with it.

The repo was created to go along with this blog post: <https://willwarren.com/2017/10/redis-cluster-cheatsheet/>

## Prerequisites

1. You need `redis-server` on your `PATH`

For `redis-trib.rb` to work properly you need:

1. Ruby
1. `gem install redis`

## Usage

To spin up 3 empty master nodes (ports 7001-7003):

```bash
./start-7000.sh
```

To turn those nodes into a cluster:

```bash
./redis-trib.rb create \
127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003
```

To add 3 more empty masters (ports 8001-8003), and then turn those into slaves

```bash
./start-8000.sh

./redis-trib.rb add-node \
--slave 127.0.0.1:8001 \
127.0.0.1:7001

./redis-trib.rb add-node \
--slave 127.0.0.1:8002 \
127.0.0.1:7001

./redis-trib.rb add-node \
--slave 127.0.0.1:8003 \
127.0.0.1:7001
```

To add a 4th master (port 9001) and rebalance some hash slots onto it:

```bash
./start-9000.sh

./redis-trib.rb add-node \
--slave 127.0.0.1:9001 \
127.0.0.1:7001

./redis-trib.rb rebalance \
--use-empty-masters \
127.0.0.1:7001
```

The script `stop.sh` will kill all redis-server processes it can find on the machine. `cleanup.sh` will delete all the AOF and dump.rdb files as well as remove the nodes configuration, effectively resetting the cluster back to the beginning.

Enjoy!
