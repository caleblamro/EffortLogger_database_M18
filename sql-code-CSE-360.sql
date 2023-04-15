CREATE TABLE `orgs` (
  `name` varchar(255) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `employees` int NOT NULL,
  `projects` int NOT NULL,
  `avg_velocity` float DEFAULT NULL,
  PRIMARY KEY (`id`,`employees`,`projects`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `org_id` int NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `hashed_password` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`user_name`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `orgs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `projects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `life_cycles_id` int NOT NULL,
  `org_id` int NOT NULL,
  `start_date` date NOT NULL,
  `est_end_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`),
  CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`org_id`) REFERENCES `orgs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `life_cycles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `life_cycles_array` json NOT NULL,
  `project_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` multilinestring NOT NULL,
  `start_date` date NOT NULL,
  `est_end_date` date NOT NULL,
  `tasks_left` int NOT NULL,
  `total_tasks` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `life_cycles_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `effort_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `defect_ids` json DEFAULT NULL,
  `task_desc` LINESTRING NOT NULL,
  `life_cycle_id` int NOT NULL,
  `time_worked_seconds` decimal(10,0) NOT NULL,
  `date_worked` date NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `employee_id` (`employee_id`),
  CONSTRAINT `effort_logs_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`),
  CONSTRAINT `effort_logs_ibfk_2` FOREIGN KEY (`life_cycle_id`) REFERENCES `life_cycles`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `employee_projects` (
  `employee_id` int NOT NULL,
  `project_id` int NOT NULL,
  PRIMARY KEY (`employee_id`,`project_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `employee_projects_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `employee_projects_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
