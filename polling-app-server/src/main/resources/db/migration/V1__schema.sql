CREATE TABLE "users" (
                       id bigserial PRIMARY KEY,
                       name varchar(40) NOT NULL,
                       username varchar(15) NOT NULL,
                       email varchar(40) NOT NULL,
                       password varchar(100) NOT NULL,
                       created_at timestamp DEFAULT CURRENT_TIMESTAMP,
                       updated_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX uk_users_username ON users (username);
CREATE UNIQUE INDEX uk_users_email ON users (email);

CREATE TABLE roles (
                       id bigserial PRIMARY KEY,
                       name varchar(60) NOT NULL
);

CREATE UNIQUE INDEX uk_roles_name ON roles (name);

CREATE TABLE user_roles (
                            user_id bigint NOT NULL,
                            role_id bigint NOT NULL,
                            PRIMARY KEY (user_id, role_id),
                            CONSTRAINT fk_user_roles_role_id FOREIGN KEY (role_id) REFERENCES roles (id),
                            CONSTRAINT fk_user_roles_user_id FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE INDEX fk_user_roles_role_id ON user_roles (role_id);

CREATE TABLE polls (
                       id bigserial PRIMARY KEY,
                       question varchar(140) NOT NULL,
                       expiration_date_time timestamp NOT NULL,
                       created_at timestamp DEFAULT CURRENT_TIMESTAMP,
                       updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
                       created_by bigint,
                       updated_by bigint
);

CREATE TABLE choices (
                         id bigserial PRIMARY KEY,
                         text varchar(40) NOT NULL,
                         poll_id bigint NOT NULL,
                         CONSTRAINT fk_choices_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id)
);

CREATE INDEX fk_choices_poll_id ON choices (poll_id);

CREATE TABLE votes (
                       id bigserial PRIMARY KEY,
                       user_id bigint NOT NULL,
                       poll_id bigint NOT NULL,
                       choice_id bigint NOT NULL,
                       created_at timestamp DEFAULT CURRENT_TIMESTAMP,
                       updated_at timestamp DEFAULT CURRENT_TIMESTAMP,
                       CONSTRAINT fk_votes_user_id FOREIGN KEY (user_id) REFERENCES users (id),
                       CONSTRAINT fk_votes_poll_id FOREIGN KEY (poll_id) REFERENCES polls (id),
                       CONSTRAINT fk_votes_choice_id FOREIGN KEY (choice_id) REFERENCES choices (id)
);

CREATE INDEX fk_votes_user_id ON votes (user_id);
CREATE INDEX fk_votes_poll_id ON votes (poll_id);
CREATE INDEX fk_votes_choice_id ON votes (choice_id);