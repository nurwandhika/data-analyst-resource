---

# 🕸 Graph Programming Language (GPL) – Fundamentals to Advanced

---

## 📌 1. Introduction

**Graph Programming Languages (GPLs)** are query languages used to **store, query, and analyze graph data**.

A **graph** consists of:

* **Vertices (nodes)** → entities (e.g., users, products).
* **Edges (relationships)** → connections (e.g., follows, purchased).
* **Properties** → attributes of nodes/edges (e.g., age, transaction date).

Graph databases are useful for:

* Social networks (who follows who).
* Recommendation systems (users similar to you).
* Fraud detection (suspicious transaction chains).
* Network analysis (dependencies, shortest paths).

---

## ⚙️ 2. Graph Fundamentals

### Graph Types

* **Directed Graph** → edges have direction (A → B).
* **Undirected Graph** → edges are bidirectional (A – B).
* **Weighted Graph** → edges have weights (cost, distance, rating).
* **Property Graph** → nodes & edges can store key-value pairs.

### Basic Terminology

* **Degree** → number of edges connected to a node.
* **Path** → sequence of nodes/edges.
* **Cycle** → closed path.
* **Traversal** → navigating graph step by step.

---

## 🐣 3. Basic Level – Queries & Traversals

### Create Nodes & Edges

```cypher
-- Example in Cypher (Neo4j style)
CREATE (u:User {id: 1, name: "Alice"})
CREATE (u2:User {id: 2, name: "Bob"})
CREATE (u)-[:FOLLOWS]->(u2)
```

### Match / Query Nodes

```cypher
-- Find all users
MATCH (u:User) RETURN u;

-- Find Alice's followers
MATCH (u:User {name: "Alice"})<-[:FOLLOWS]-(f)
RETURN f;
```

### Basic Traversal

```gremlin
# Gremlin style
g.V().has("User","name","Alice").out("FOLLOWS")
```

---

## 🐤 4. Intermediate Level – Patterns & Aggregations

### Filtering

```cypher
MATCH (u:User)-[:PURCHASED]->(p:Product)
WHERE p.price > 100
RETURN u.name, p.name;
```

### Counting & Grouping

```cypher
-- Top 5 most followed users
MATCH (u:User)<-[:FOLLOWS]-(f:User)
RETURN u.name, COUNT(f) AS followers
ORDER BY followers DESC
LIMIT 5;
```

### Paths & Shortest Path

```cypher
-- Find shortest path between Alice and Bob
MATCH path = shortestPath(
  (a:User {name:"Alice"})-[:FOLLOWS*]-(b:User {name:"Bob"})
)
RETURN path;
```

### Updating Graph

```cypher
-- Add property to an edge
MATCH (u:User {name:"Alice"})-[r:FOLLOWS]->(b:User {name:"Bob"})
SET r.since = "2025-08-18"
```

---

## 🦅 5. Advanced Level – Graph Algorithms

### Centrality

* **Degree centrality** → most connected nodes.
* **Betweenness centrality** → nodes bridging communities.
* **PageRank** → importance measure (used in Google Search).

```cypher
CALL algo.pageRank.stream("User","FOLLOWS")
YIELD nodeId, score
RETURN algo.getNodeById(nodeId).name, score
ORDER BY score DESC
```

### Community Detection

* Detect clusters of strongly connected users.
* Algorithms: Louvain, Label Propagation.

```cypher
CALL algo.louvain.stream("User","FOLLOWS")
YIELD nodeId, community
RETURN algo.getNodeById(nodeId).name, community
```

### Recommendation Systems

```cypher
-- Recommend products purchased by similar users
MATCH (u:User {name:"Alice"})-[:PURCHASED]->(p:Product)<-[:PURCHASED]-(other:User)-[:PURCHASED]->(rec:Product)
WHERE NOT (u)-[:PURCHASED]->(rec)
RETURN rec, COUNT(*) AS score
ORDER BY score DESC
LIMIT 5;
```

### Graph Traversal Depth Control

```gremlin
# Gremlin example: friends of friends up to 2 hops
g.V().has("User","name","Alice").repeat(out("FOLLOWS")).times(2).dedup()
```

---

## 🛡️ 6. Best Practices

* ✅ Use **labels** for clarity (`:User`, `:Product`, `:Transaction`).
* ✅ Use **properties** instead of creating too many node types.
* ✅ Limit traversal depth to avoid runaway queries.
* ✅ Use indexes on frequently searched properties (e.g., `CREATE INDEX FOR (u:User) ON (u.id)`).
* ✅ Store timestamps & metadata for reproducibility.
* ✅ Avoid Cartesian products (`MATCH (a),(b)`) unless intended.

---

## 🐞 7. Troubleshooting

| Issue               | Root Cause                      | Solution                               |
| ------------------- | ------------------------------- | -------------------------------------- |
| Query runs too slow | No index / deep traversal       | Create index, add LIMIT, control depth |
| Out of memory       | Too many paths expanded         | Use shortestPath or LIMIT hops         |
| Duplicate results   | Multiple paths return same node | Use `DISTINCT` or `dedup()`            |
| Wrong relationships | Edge direction mismatch         | Verify schema with sample queries      |

---

## 📖 8. Technical Fundamentals

### Query Languages

* **Cypher (Neo4j)** → declarative, SQL-like.
* **Gremlin (Apache TinkerPop)** → imperative, step-by-step traversal.
* **GraphQL** → query graphs via APIs (not graph DB specific).

### Storage Models

* **Adjacency list** (most common in graph DBs).
* **Adjacency matrix** (rare, used in memory-heavy algorithms).

### Complexity

* Traversals can be **O(n)** or worse → design queries carefully.
* Graph algorithms often rely on **iterative propagation** (PageRank, Louvain).

---

## 📋 9. Quick Reference Cheatsheet

| Operation     | Cypher Example                             | Gremlin Example                               |
| ------------- | ------------------------------------------ | --------------------------------------------- |
| Create node   | `CREATE (u:User {name:"Alice"})`           | `g.addV("User").property("name","Alice")`     |
| Create edge   | `MATCH (a),(b) CREATE (a)-[:FOLLOWS]->(b)` | `g.V(a).addE("FOLLOWS").to(g.V(b))`           |
| Match node    | `MATCH (u:User {name:"Alice"}) RETURN u`   | `g.V().has("User","name","Alice")`            |
| Traversal     | `MATCH (u)-[:FOLLOWS]->(f) RETURN f`       | `g.V().out("FOLLOWS")`                        |
| Shortest path | `shortestPath((a)-[:FOLLOWS*]-(b))`        | `g.V(a).repeat(out()).until(hasId(b)).path()` |

---

## 🔗 10. References

* [Neo4j Cypher Docs](https://neo4j.com/docs/cypher-refcard/current/)
* [Gremlin – Apache TinkerPop](https://tinkerpop.apache.org/gremlin.html)
* [Graph Algorithms Book (Neo4j)](https://neo4j.com/graph-algorithms-book/)
* [Graph Databases Explained](https://www.dataversity.net/what-is-a-graph-database/)

---

✅ This doc covers:

* Fundamentals of graphs (nodes, edges, traversals).
* **Basic → Intermediate → Advanced queries**.
* Best practices & troubleshooting.
* Comparison between **Cypher vs Gremlin** styles.
* A quick cheatsheet for day-to-day use.

---
