Day 2 | Advanced Database (Adv DB)
## Data Storage & Scanning
 * Storage: Data is stored on the hard disk in Pages. When querying, you generally have to retrieve all records in order.
 * Postgres Storage: In Postgres, data is not saved in order.
 * Parallel Sequential Scan: Uses two or more pointers to search through data. The time complexity is O(n).
 
## Tree-Based Indexes
 * B-Tree:
   * Some databases use B-Trees.
   * Balancing: The tree must always rebalance to ensure |R - L| \le 1 (the difference between the right level and left levels is at most 1).
   * Queries: Can handle Point Queries and Range Queries well, especially at big ranges. Time complexity for searches is generally m \log(n), though large range queries might approach O(n).
 * B+Tree:
   * The leaf nodes contain all the actual values, linked together.
   * You can search for the minimum value in O(n) and use the leaf node pointers to easily retrieve the other values in a range.

## Downsides of Indexes
 * Space: They take up additional storage space.
 * Overhead on DML Operations: Rebalancing the tree happens not just on the main table, but also on the indexes during Data Manipulation Language (DML) operations (Insert, Update, Delete).
 * Trade-off: Indexes result in good searching but bad updating.
 * Cardinality: Indexes are much more useful if a column has many unique values (high cardinality).

## Scan Types
 * Parallel Sequential Scan: Scanning the whole table using multiple pointers.
 * Index Only Scan: Uses only the index to find the data. This happens when the requested data is completely contained within the index tree itself, so there is no need to visit the main table.
 * Index Scan (Ctid): * Uses the index to find the pointer to the data, then goes back to the main table to get the rest of the data.
   * Ctid: Contains the id, page_number, and row.

## Other Index Types
 * Hash Index: Maps an indexed column to a physical place. It takes the Key (Values), runs it through a Hash Function, and saves it to a specific physical location.
 * Fuzzy Index: Uses a Trie data structure. Commonly used in search engines.
 * Bitmap Index: (Mentioned briefly).
6. Clustered vs. Non-Clustered Indexes
 * Clustered Index (e.g., MySQL): The table itself is a B-tree. The data is physically stored in order. The first index you create determines this B-tree layout.
 * Non-Clustered Index (e.g., Postgres): The table data is not physically ordered on the disk.

## Composite Indexes
 * If you are selecting based on multiple columns, you can create an index on more than one column.
 * Order Matters: If you have an index on [C1, C2, C3], it will search on C1 (ordered), then find C2 (ordered).
   * Example: Search on first_name \rightarrow then last_name \rightarrow then third_name.
 * Usage Rules (Left-Most Prefix):
   * Querying C1 \rightarrow Uses index.
   * Querying C1, C2 \rightarrow Uses index.
   * Querying C1, C2, C3 \rightarrow Uses index.
   * Querying C2, C1 \rightarrow Uses index (optimizer will rearrange to get C1, C2).
   * Querying only C3 \rightarrow Will not use the index. #### 8. Golden Rule for Indexed Columns
 * Rule: Using a function on an indexed column in your query will cause the database to not use the index.
 * Solution: Create an Index on the function (Functional Index) directly.
