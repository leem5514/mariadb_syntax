--  author
create table author (
    id int auto_increment,
    name varchar(255),
    email VARCHAR(255) NOT NULL,
    created_time DATETIME default current_timestamp,
	PRIMARY KEY(id),
    unique(email)
)

-- post
create table post (
	id int auto_increment,
	title varchar(255) not null,
	contents varchar(3000),
	primary key(id)
);

-- author_address
create table author_address (
	id int auto_increment,
    country varchar(255),
	city varchar(255),
	street varchar(255),
	author_id int not null,
	FOREIGN KEY (author_id) REFERENCES author(id) on delete cascade,
	primary key(id),
	unique(author_id)
);

-- author_post
create table author_post (
	id int auto_increment,
	author_id int not null,
	post_id int not null,
	primary key(id),
	FOREIGN KEY (author_id) REFERENCES author(id),
	FOREIGN KEY (post_id) REFERENCES post(id),
	-- unique(post_id)
);

