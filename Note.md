


================================================================================================================
================================================================================================================
# Swap Memory
================================================================================================================
================================================================================================================
If you check the logs, you'll see the application starts successfully but gets **killed during the health check**. 
This usually happens because other processes on the EC2 instance are consuming memory, 
or there is a **lack of Swap memory**.

### What is Swap Memory?

**Analogy:**

* **RAM (Physical Memory):** Your workspace on top of your desk.
* **Swap (Disk Space):** A drawer next to your desk.

When your desk is full, you move less important documents into the drawer and take them back out only when needed.

**Technical Definition:**

* Virtual memory that uses the disk as if it were RAM.
* Used temporarily when RAM is exhausted.
* **Slower than RAM**, but prevents the system from crashing.

### Why is the process killed without Swap?

**How the Linux OOM (Out Of Memory) Killer Works:**

1. RAM usage increases and reaches 100%.
2. System checks: **"Is there any Swap memory?"**
3. If **NO**  Emergency!
4. The **OOM Killer** activates: It forcefully terminates (Kills) the process using the most memory to save the system.

**What happened in your EC2:**

1. Java application starts.
2. Uses about 3GB out of 3.8GB RAM.
3. Health check request triggers  Spring requires additional memory for initialization.
4. RAM is insufficient  **No Swap available!**
5. OOM Killer: "Java is using the most memory!"  **KILLED.**

### Why Java/Spring Boot consumes so much memory

1. **JVM Structure:** Java runs its own virtual machine on top of the OS, consuming memory for the **Heap** (object storage), **Metaspace**, and **Garbage Collection**.
2. **Spring Boot Features:** It loads a lot of components at startup:
* Spring Framework (IoC Container, Bean Factory).
* Auto-configurations (Embedded Tomcat, Hibernate/JPA, Jackson).
* Database Connection Pools (e.g., HikariCP).


3. **Memory Spike Pattern:** Memory usage jumps significantly during the **first HTTP request** (like a health check) as the `DispatcherServlet` and lazy-loaded Beans are initialized.

### Solution Summary

1. **Limit Java Heap Memory:** Use flags like `-Xmx1024m -Xms512m` to prevent Java from requesting unlimited memory.
2. **Add 2GB of Swap Memory:** This ensures that even if RAM is full, the process survives the temporary spike by using disk space.



================================================================================================================
================================================================================================================
# Proxy & Nginx
================================================================================================================
================================================================================================================


**Proxy** and **Nginx** are terms that appear constantly in server architecture. Here is an easy breakdown.

## 1. What is a Proxy?

A **Proxy** literally means an **"agent"** or **"representative."** It is an intermediary server that passes communication between a client (you) and a server (the website).

* **Forward Proxy:** Sits in front of the **client**. Used to hide the client's IP or bypass firewalls (e.g., a corporate proxy).
* **Reverse Proxy:** Sits in front of the **web server**. It receives requests from the internet and forwards them to internal servers. **This is the primary role of Nginx.**

## 2. What is Nginx?

**Nginx** is high-performance, lightweight **web server software**. While older software like Apache exists, Nginx is the modern standard because it can handle a massive number of simultaneous connections with very few resources.

**Key Functions:**

1. **Web Server:** Serves static files (HTML, images) directly to users.
2. **Reverse Proxy:** Forwards requests to backend servers (Node.js, Java, Python).
3. **Load Balancing:** Distributes traffic across multiple servers to prevent overload.

## 3. The Relationship Between Nginx and Proxy

The core answer is: **"Nginx is one of the most popular tools used to implement a Reverse Proxy."**

**Benefits of using Nginx as a Proxy:**

* **Security:** Hides the internal server's IP from the public.
* **Speed (Caching):** Stores frequently requested data to respond faster.
* **SSL Termination (HTTPS):** Handles complex SSL encryption in one place so the backend doesn't have to.

---

### Summary

* **Proxy** is the **concept/role** (the intermediary).
* **Nginx** is the **software/product** that performs that role excellently.

Would you like me to provide the specific Linux commands to set up the 2GB Swap file on your EC2 instance?