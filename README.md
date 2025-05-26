# Assignment 2

## 1. What is PostgreSQL?

PostgreSQL হলো একটি শক্তিশালী, ওপেন-সোর্স রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম (RDBMS) যা SQL (Structured Query Language) ব্যবহার করে। এটি ডেটা স্টোর এবং ম্যানিপুলেট করার জন্য একটি স্ট্যান্ডার্ড পদ্ধতি সরবরাহ করে, যা বিভিন্ন অ্যাপ্লিকেশন এবং সার্ভারের জন্য ব্যবহার করা হয়। 

### বৈশিষ্ট্যসমূহ:

**1. Open Source & Free**
- এর সোর্স কোড বিনামূল্যে এবং উন্মুক্ত, যা ব্যবহারকারীদের এটি ব্যবহার, পরিবর্তন এবং বিতরণ করার স্বাধীনতা দেয়।
- একটি International Developer দ্বারা সক্রিয়ভাবে উন্নয়ন ও রক্ষণাবেক্ষণ করা হয়।

**2. Relational and Object-Oriented**
- Data কোয়েরির জন্য স্ট্যান্ডার্ড SQL ভাষা অনুসরণ করে।
- টেবিল Inheritance ও কাস্টম টাইপের মতো অবজেক্ট-ওরিয়েন্টেড ফিচার সাপোর্ট করে।

**3. Data Integrity and Reliability**

- ACID-compliant (Atomicity, Consistency, Isolation, Durability).
- মজবুত ট্রানজ্যাকশনাল সাপোর্ট ও ক্র্যাশ recovery.

**4. Extensibility**

- ব্যবহারকারী কাস্টম ডেটা টাইপ, ফাংশন এবং অপারেটর ব্যবহার করতে পারে।

**5. Cross-Platform**

- Windows, macOS, Linux এবং অন্যান্য সিস্টেমে কাজ করে.

### ব্যবহার:

- ওয়েব অ্যাপ্লিকেশন
- ডেটা warehousing and analytics
- আর্থিক ও বৈজ্ঞানিক অ্যাপ্লিকেশন ইত্যাদি।

#### উদাহরন:

```
CREATE TABLE users (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL
);

INSERT INTO users (name, email) VALUES ('Shakil', 'sakilahmed7810@gmail.com');
```

## 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

PostgreSQL-এ প্রাইমারি কি এবং ফরেইন কি ডেটা ইন্টেগ্রিটি বজায় রাখা এবং টেবিলগুলোর মধ্যে সম্পর্ক তৈরি করার জন্য অত্যন্ত গুরুত্বপূর্ণ।

### Primary Key

প্রাইমারি কি হলো এমন একটি কলাম বা কলামের সমন্বয় যা:

- প্রতিটি সারিকে অনন্যভাবে চিহ্নিত করে।
- কখনও NULL হতে পারে না।
- দ্রুত সার্চের জন্য স্বয়ংক্রিয়ভাবে ইনডেক্স করা হয়।
- প্রতিটি টেবিলে একটি unique এবং non-null ID থাকা আবশ্যক।

#### উদাহরন:

```
CREATE TABLE students (
id SERIAL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL
);
```


### Foreign Key
ফরেইন কি এমন একটি কলাম বা কলামের সমন্বয় যা:

- অন্য একটি টেবিলের প্রাইমারি Key-কে রেফারেন্স করে।
- দুইটি টেবিলের মধ্যে সম্পর্ক তৈরি করে।
- Referential integrity বজায় রাখে।

#### উদাহরন:
```
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES students(id),
  product TEXT
);
```


## 3. What is the difference between the VARCHAR and CHAR data types?
PostgreSQL-এ VARCHAR এবং CHAR উভয়ই টেক্সট ডেটা সংরক্ষণের জন্য ব্যবহৃত হয়, তবে এগুলোর আচরণ সংরক্ষণ, প্যাডিং এবং পারফরমেন্স ভিন্ন।

### VARCHAR
- ভ্যারিয়েবল type string।
- যতটুকু দরকার ততটুকু space ব্যবহার করে।
- কোনো প্যাডিং হয়।
- সামান্য ধীর হতে পারে।
- সর্বাধিক ব্যবহৃত এবং flexible

#### উদাহরন:
```
CREATE TABLE users (
  name VARCHAR(100)
);
```

### CHAR
- নির্দিষ্ট দৈর্ঘ্যের string টাইপ।
- সব সময় নির্ধারিত সংখ্যক ক্যারেক্টার ব্যবহার করে।
- Input ছোট হলে space দিয়ে পূরণ করে।
- স্থির আকারের ডেটার জন্য সামান্য দ্রুত হতে পারে।
- যখন সমস্ত মান একই দৈর্ঘ্যের হবে তখন ব্যবহার করা হয়।

#### উদাহরন:
```
CREATE TABLE users (
  country_code CHAR(2)
);
```


## 4. Explain the purpose of the WHERE clause in a SELECT statement
SELECT স্টেটমেন্টে WHERE clause - টি নির্দিষ্ট শর্ত অনুযায়ী সারি নির্বাচন করতে ব্যবহৃত হয়। এটি শুধুমাত্র শর্ত পূরণ করা সারিগুলিই query ফলাফলে আসবে।

### Purpose of WHERE Clause:
- Query দ্বারা ফেরত আসা ডেটা সীমিত করে।
- কলামে শর্ত প্রয়োগ করে।
- কোয়েরিকে আরো নির্দিষ্ট, কার্যকর এবং বিশ্লেষণ উপযোগী করে তোলে।

#### উদাহরন:
```
CREATE Table rangers (
    ranger_id SERIAL PRIMARY KEY UNIQUE,
    name VARCHAR(100) NOT NULL,
    age INT
);

INSERT INTO rangers VALUES('Shakil Ahamed', 25), ('Sayla', 21), ('Siuli', 17);

SELECT * FROM rangers WHERE age > 18;
SELECT * FROM rangers WHERE name = 'Sayla';

```

### Common Operators Used with WHERE:
- = , != or <>, 
- <, >, <=, >=
- BETWEEN, LIKE, IN
- IS NULL, IS NOT NULL
- Logical: AND, OR, NOT


## 5. What are the LIMIT and OFFSET clauses used for?
SQL বিশেষ করে PostgreSQL-এ, LIMIT এবং OFFSET clause কোয়েরির ফলাফলে ফেরত আসা সারির সংখ্যা নিয়ন্ত্রণ করতে ব্যবহৃত হয়। এটি pagination এবং performance এর জন্য ব্যবহৃত হয়।

### LIMIT Clause
- ফেরত আসা সারির সংখ্যা সীমিত করে।
- সর্বোচ্চ কতটি সারি দেখাবে তা নির্ধারণ করে।

#### উদাহরন:
```
SELECT * FROM rangers
LIMIT 5;

```


### OFFSET Clause
- ফলাফল ফেরতের আগে নির্দিষ্ট সংখ্যক সারি বাদ দেয়।
- বেশি ভাগ সময়ই LIMIT-এর সাথে একত্রে ব্যবহার হয় pagination করার জন্য।


#### উদাহরন:
```
SELECT * FROM rangers
OFFSET 5;

**Skips the first 5 rows, then returns all remaining rows.**
```

### বৈশিষ্ট্যসমূহ: Pagination in Web Apps
```
SELECT * FROM rangers LIMIT 10 OFFSET 0;
- প্রথম ১০টি সারি দেখাবে
SELECT * FROM rangers LIMIT 10 OFFSET 10;
- পরবর্তী ১০টি সারি দেখাবে
SELECT * FROM rangers LIMIT 10 OFFSET 20;
- এর পরের ১০টি সারি দেখাবে
```