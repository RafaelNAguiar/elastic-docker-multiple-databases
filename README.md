# Elasticsearch with Docker and data from multiple databases

A sample project that unites all the configurations and files necessary to run a Elastisearch cluster with Docker using data from multiple and, possibly, diferent database engines.

## Getting Started

### Prerequisites

For this setup to work you need installed in your machine Docker and Docker Compose. The Docker installables and instructions for your operating system can be found <a href="https://www.docker.com/get-started" target="_blank">here</a> and the Docker Compose's >a href="https://docs.docker.com/compose/install/">here</a>.

### Sample Data

For this example I used a very simple data model where the data about person's names are in a MySQL database and their ages is in a PosgreSQL database that have a field named "mysql_id" that have the id from the name table in the MySQL database.
To initialize the MySQL database we will use the code below:

```

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

create database elastic;

use elastic;

-- ----------------------------
-- Table structure for name
-- ----------------------------
DROP TABLE IF EXISTS `name`;
CREATE TABLE `name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of name
-- ----------------------------
BEGIN;
INSERT INTO `name` VALUES (1, 'Sara');
INSERT INTO `name` VALUES (2, 'Manuela');
INSERT INTO `name` VALUES (3, 'Rosana');
INSERT INTO `name` VALUES (4, 'Francielly');
INSERT INTO `name` VALUES (5, 'Olívia');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;

```

And, to initialize the age table, in the PostgreSQL, we will use the code below:

```

CREATE SEQUENCE age_id_seq START 1;

DROP TABLE IF EXISTS "public"."age";
CREATE TABLE "public"."age" (
  "id" int2 NOT NULL DEFAULT nextval('age_id_seq'::regclass),
  "age" int4,
  "mysql_id" int4
)
;
ALTER TABLE "public"."age" OWNER TO "postgres";

-- ----------------------------
-- Records of age
-- ----------------------------
BEGIN;
INSERT INTO "public"."age" VALUES (1, 10, 1);
INSERT INTO "public"."age" VALUES (2, 20, 2);
INSERT INTO "public"."age" VALUES (3, 30, 3);
INSERT INTO "public"."age" VALUES (4, 40, 4);
INSERT INTO "public"."age" VALUES (5, 50. 5);
COMMIT;

-- ----------------------------
-- Primary Key structure for table age
-- ----------------------------
ALTER TABLE "public"."age" ADD CONSTRAINT "age_pkey" PRIMARY KEY ("id");

```

Both sql scripts are located in this project in the folders "elastic-name" and "elastic-age", that are linked to the init folders of the MySQL and PostgreSQL images in the docker-compose.yml file.


### Installing

Now that you have both Docker and Docker Compose running you can, from the folder where you cloned the project type, type the following command:

```
docker-compose up
```

You soon will see messages from the containers starting, including the messages from Logstash indicating if the creation of the index was successfull or if it failed.


## Testing the result

Due to the lack of auth for the Elasticsearch in this project, just by going trought your browser and pasting the following url <a href="http://localhost:9200/person/_search">http://localhost:9200/person/_search</a> you will be able to get the result below:

```

{
   "took":1132,
   "timed_out":false,
   "_shards":{
      "total":1,
      "successful":1,
      "skipped":0,
      "failed":0
   },
   "hits":{
      "total":{
         "value":5,
         "relation":"eq"
      },
      "max_score":1.0,
      "hits":[
         {
            "_index":"person",
            "_type":"_doc",
            "_id":"2",
            "_score":1.0,
            "_source":{
               "@timestamp":"2020-04-29T05:44:00.141Z",
               "name":"Manuela",
               "id":2,
               "age":"%{[extra][0][age]}",
               "@version":"1",
               "tags":[
                  "_jdbcstreamingdefaultsused"
               ]
            }
         },
         {
            "_index":"person",
            "_type":"_doc",
            "_id":"1",
            "_score":1.0,
            "_source":{
               "@timestamp":"2020-04-29T05:44:00.141Z",
               "name":"Sara",
               "id":1,
               "age":"%{[extra][0][age]}",
               "@version":"1",
               "tags":[
                  "_jdbcstreamingdefaultsused"
               ]
            }
         },
         {
            "_index":"person",
            "_type":"_doc",
            "_id":"3",
            "_score":1.0,
            "_source":{
               "@timestamp":"2020-04-29T05:44:00.142Z",
               "name":"Rosana",
               "id":3,
               "age":"%{[extra][0][age]}",
               "@version":"1",
               "tags":[
                  "_jdbcstreamingdefaultsused"
               ]
            }
         },
         {
            "_index":"person",
            "_type":"_doc",
            "_id":"5",
            "_score":1.0,
            "_source":{
               "@timestamp":"2020-04-29T05:44:00.143Z",
               "name":"Olívia",
               "id":5,
               "age":"%{[extra][0][age]}",
               "@version":"1",
               "tags":[
                  "_jdbcstreamingdefaultsused"
               ]
            }
         },
         {
            "_index":"person",
            "_type":"_doc",
            "_id":"4",
            "_score":1.0,
            "_source":{
               "@timestamp":"2020-04-29T05:44:00.143Z",
               "name":"Francielly",
               "id":4,
               "age":"%{[extra][0][age]}",
               "@version":"1",
               "tags":[
                  "_jdbcstreamingdefaultsused"
               ]
            }
         }
      ]
   }
}

```

## Customization

To make this project your own, you probably will need to change the databases, their data their Logstash output.

To change the database engine, you will need to change the image in the docker-compose.yml file, set the enviroment variables accordling and change the initialization script to one that maches your data structure and image init configurations.
The second step would be download the jdbc driver to your database engine, save in the logstash folder and configure the logstash.conf with the correct setting for your driver, driver path, username, password and query.


## Authors

* **Rafael Aguiar**

## License

This project is licensed under the <a href="http://opensource.org/licenses/mit-license.php" rel="nofollow">MIT license</a>
