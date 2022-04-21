CREATE USER chaneto with ENCRYPTED PASSWORD '12345';

CREATE DATABASE personal_information with OWNER chaneto;

GRANT ALL PRIVILEGES ON DATABASE personal_information TO chaneto;

CREATE TYPE gender AS ENUM ('male', 'female');
CREATE TABLE personal(
id serial PRIMARY KEY,
first_name VARCHAR(100) NOT NULL,
last_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
age INT,
gender gender
);

CREATE TABLE employments(
id serial PRIMARY KEY,
employment VARCHAR(100) NOT NULL,
person_id INT,
CONSTRAINT fk_employment_person
FOREIGN KEY (person_id)
REFERENCES personal(id)
);

CREATE TABLE addresses(
id serial PRIMARY KEY,
country VARCHAR(100) NOT NULL,
city VARCHAR(100) NOT NULL,
street VARCHAR(100) NOT NULL,
number INT NOT NULL,
person_id INT,
CONSTRAINT fk_addresses_person
FOREIGN KEY (person_id)
REFERENCES personal(id)
);

CREATE TABLE social_network_profiles(
id serial PRIMARY KEY,
name VARCHAR(100) NOT NULL,
person_id INT NOT NULL UNIQUE
);


DO $$DECLARE
  gender gender;
  n int;
  small_char int;
  big_char int;
  first_name varchar(5);
  last_name varchar(5);
BEGIN
  for i in 1..1000000 loop
     n:=(random()*79 + 1);
	 small_char:=(random()*20 + 97);
	 big_char:=(random()*23 + 65);
	 first_name = concat(CHR(big_char), CHR(small_char+3), CHR(small_char+5), CHR(small_char+2), CHR(small_char+1));
	 last_name = concat(CHR(big_char+1), CHR(small_char+5), CHR(small_char+3), CHR(small_char+1), CHR(small_char+4));
  IF n % 2 = 0  THEN
  gender = 'male';
  ELSE 
  gender = 'female';
  END IF;
     insert into personal values(i ,first_name, last_name, concat('Petko', i, '@abv.bg'), n , gender);
  end loop;
END$$;

EXPLAIN ANALYZE select * from personal where first_name = 'Xqspo';

CREATE INDEX fh_ln_email ON personal (first_name, last_name, email); 

EXPLAIN ANALYZE select * from personal where first_name = 'Xqspo';



