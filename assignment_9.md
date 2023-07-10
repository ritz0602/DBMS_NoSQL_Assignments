### Q1. What are the main features of redis?

### Ans:

### The main features of Redis (Remote Dictionary Server) include:

- **In-Memory Data Storage:** Redis primarily stores data in memory, providing fast read and write operations. It allows for high-performance caching and real-time data processing.

- **Data Structures:** Redis supports various data structures such as strings, lists, sets, hashes, sorted sets, and bitmap operations. These data structures offer flexibility and enable complex operations on stored data.

- **Persistence:** Redis provides options for persistence, allowing data to be stored on disk for durability. It supports snapshotting, where the entire dataset is periodically written to disk, as well as append-only file (AOF) persistence, which logs every write operation.

- **Pub/Sub Messaging:** Redis includes a publish/subscribe messaging system, enabling communication between different clients through channels and message passing.

- **Replication and High Availability:** Redis supports replication, allowing data to be replicated across multiple nodes for increased fault tolerance and availability. It also offers built-in mechanisms for handling failover.

- **Lua Scripting:** Redis allows for scripting using Lua, enabling complex operations to be executed on the server side.

- **Transactions:** Redis supports atomic transactions, which ensure that a series of operations are executed as a single isolated unit, maintaining consistency.

### Q2. Write down the limitations of redis?

### Ans:

### Limitations of Redis include:

- **Limited Storage Capacity:** Since Redis primarily relies on in-memory storage, the available storage capacity is limited by the amount of RAM available. Large datasets may require careful memory management or partitioning strategies.

- **Single-Threaded Nature:** Redis is single-threaded by design, which means that a single Redis instance can only utilize a single CPU core. This can limit the system's ability to scale horizontally for concurrent processing.

- **Lack of Query Language:** Redis does not have a built-in query language like SQL. While it supports basic operations and data retrieval, complex querying requires additional programming logic on the client side.

- **No Built-in Security:** Redis does not provide built-in authentication or access control mechanisms. It is necessary to configure external security measures to secure Redis instances.

### Q3. Perform a basic CRUD operation using redis.

### Ans:

### Basic CRUD operations using Redis:

To perform basic CRUD (Create, Read, Update, Delete) operations in Redis, you can use the following commands:

- **Create:** To create a key-value pair in Redis, use the SET command. For example, to create a key "name" with the value "John", you can run the command:

```
SET name John
```

- **Read:** To retrieve the value of a key in Redis, use the GET command. For example, to read the value of the "name" key, you can run the command:

```
GET name
```

- **Update:** To update the value of an existing key in Redis, you can simply reissue the SET command with the new value. For example, to update the value of the "name" key to "Jane", you can run the command:

```
SET name Jane
```

- **Delete:** To delete a key and its associated value in Redis, use the DEL command. For example, to delete the "name" key, you can run the command:

```
DEL name
```

### Q4. Explain TTL command with an example.

### Ans:

TTL (Time To Live) command in Redis is used to set an expiration time for a key. It specifies how long a key should exist in Redis before it is automatically removed. The TTL command returns the remaining time to live for a key in seconds.
Example of using TTL command:

Assuming we have set a key "session_id" with a value "abc123" and want it to expire after 60 seconds, we can use the following commands:

1. Set the key with an expiration time:

```
SETEX user 60 Ritik
```

This command sets the value "abc123" to the key "session_id" and sets the expiration time to 60 seconds.

2. Get the remaining time to live for the key:

```
TTL session_id
```

This command will return the remaining time in seconds. If the key is still active, it will return a positive value indicating the remaining time. If the key has expired or does not exist, it will return -2 or -1 respectively.

### Q5. Create a transaction in redis to perform the following operations.

- Create two keys in a single line and one key differently. (one value should be number)
- Read any two value in a single line
- Increment the number value
- Expire any two keys after some time

### Ans:

To create a transaction in Redis to perform the specified operations, we can use the MULTI/EXEC commands.

```
MULTI
MSET fname Ritik lname Sahu
SET age 21
MGET fname lname
INCR age
EXPIRE fname 3600
EXPIRE lname 1800
EXEC
```

In this example:

The **MULTI** command initiates a transaction, indicating that subsequent commands will be executed as part of the transaction.

The **MSET** command sets multiple key-value pairs in a single line. It sets the keys "fname" and "lname" with their respective values "Ritik" and "Sahu".

The **SET** command sets the key "age" with the value "21".

The **MGET** command retrieves the values of multiple keys. It retrieves the values associated with the keys "fname" and "lname".

The **INCR** command increments the value of the key "age" by 1. Assuming the initial value is a number, it will be incremented.

The **EXPIRE** command sets expiration times for the keys "fname" and "lname". The key "fname" will expire after 3600 seconds (1 hour) and the key "lname" will expire after 1800 seconds (30 minutes).

The **EXEC** command executes the queued commands within the transaction. All the commands are executed atomically as a single unit of work.
