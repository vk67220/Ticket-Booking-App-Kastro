-- Create databases
CREATE DATABASE IF NOT EXISTS user_db;
CREATE DATABASE IF NOT EXISTS movie_db;
CREATE DATABASE IF NOT EXISTS booking_db;
CREATE DATABASE IF NOT EXISTS payment_db;
CREATE DATABASE IF NOT EXISTS admin_db;

-- Use user_db and create tables
USE user_db;

CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample users (password is 'password' hashed)
INSERT INTO users (username, password, email, first_name, last_name, role)
VALUES 
('user1', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG', 'user1@example.com', 'John', 'Doe', 'USER'),
('user2', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG', 'user2@example.com', 'Jane', 'Smith', 'USER'),
('admin', '$2a$10$xn3LI/AjqicFYZFruSwve.681477XaVNaUQbr1gioaWPn4t1KsnmG', 'admin@example.com', 'Admin', 'User', 'ADMIN');

-- Use movie_db and create tables
USE movie_db;

CREATE TABLE IF NOT EXISTS movies (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    duration INT NOT NULL,
    language VARCHAR(50) NOT NULL,
    release_date DATE,
    genre VARCHAR(50),
    director VARCHAR(100),
    poster_url VARCHAR(255),
    industry VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS theaters (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    total_screens INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS screens (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    theater_id BIGINT NOT NULL,
    screen_number INT NOT NULL,
    total_seats INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (theater_id) REFERENCES theaters(id)
);

CREATE TABLE IF NOT EXISTS showtimes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    movie_id BIGINT NOT NULL,
    screen_id BIGINT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (screen_id) REFERENCES screens(id)
);

-- Insert sample Hollywood movies
INSERT INTO movies (title, description, duration, language, release_date, genre, director, poster_url, industry)
VALUES 
('Dune: Part Two', 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.', 166, 'English', '2024-03-01', 'Sci-Fi', 'Denis Villeneuve', 'https://m.media-amazon.com/images/M/MV5BODdjMjM3NGQtZDA5OC00NGE4LWIyZDQtZjYwOGZlMTdiZjA1XkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_.jpg', 'Hollywood'),
('Godzilla x Kong: The New Empire', 'Godzilla and Kong team up against an undiscovered threat hidden within our world.', 115, 'English', '2024-03-29', 'Action', 'Adam Wingard', 'https://m.media-amazon.com/images/M/MV5BYmE4MjA1N2QtYmQ4ZC00ZmRiLWE0ZjQtYzUzMWU2MzdiNjNkXkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg', 'Hollywood'),
('The Fall Guy', 'A stuntman is thrust into a dangerous mission to find a missing movie star.', 126, 'English', '2024-05-03', 'Action', 'David Leitch', 'https://m.media-amazon.com/images/M/MV5BNGIyYmNlNzctMzczYS00NGY0LTllZjQtZTVlYzljZTRkODQ1XkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg', 'Hollywood'),
('Kingdom of the Planet of the Apes', 'Set several generations in the future following Caesar\'s reign, apes are the dominant species and humans have been reduced to living in the shadows.', 145, 'English', '2024-05-10', 'Sci-Fi', 'Wes Ball', 'https://m.media-amazon.com/images/M/MV5BNDcxM2RiOWMtMGEzMC00NDlkLTgxZjItZjNiZjUxZGQ5ZTI0XkEyXkFqcGdeQXVyMTkxNjUyNQ@@._V1_.jpg', 'Hollywood'),
('Furiosa: A Mad Max Saga', 'The origin story of renegade warrior Furiosa before her encounter with Mad Max.', 150, 'English', '2024-05-24', 'Action', 'George Miller', 'https://m.media-amazon.com/images/M/MV5BNDYyYTc4MDMtMmM0OS00ZDY3LWIzYzQtNjRkYjQzODQzZTVkXkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_.jpg', 'Hollywood');

-- Insert sample Tollywood movies
INSERT INTO movies (title, description, duration, language, release_date, genre, director, poster_url, industry)
VALUES 
('Kalki 2898 AD', 'Set in the future, this sci-fi epic follows the story of the last avatar of Lord Vishnu.', 180, 'Telugu', '2024-06-27', 'Sci-Fi', 'Nag Ashwin', 'https://m.media-amazon.com/images/M/MV5BM2I1OTU4ZmUtMTU0Yy00MGVlLWI0YWEtN2MzN2RkMGRlMTU1XkEyXkFqcGdeQXVyMTUzNTgzNzM0._V1_.jpg', 'Tollywood'),
('Game Changer', 'A political thriller focusing on electoral politics and the role of youngsters in it.', 165, 'Telugu', '2024-09-27', 'Political', 'S. Shankar', 'https://i0.wp.com/www.socialnews.xyz/wp-content/uploads/2019/02/19/Ram-Charan-s-RC-15-Movie-First-Look-Poster-.jpg?quality=80&zoom=1&ssl=1', 'Tollywood'),
('Devara: Part 1', 'An action drama set in a coastal area, following the story of a powerful and influential man.', 170, 'Telugu', '2024-10-10', 'Action', 'Koratala Siva', 'https://m.media-amazon.com/images/M/MV5BY2YwNzFhY2QtNzA3NS00MDk2LThjZjUtYjNlZjMyYmJhZTBiXkEyXkFqcGdeQXVyMTYyMTYyOTcw._V1_.jpg', 'Tollywood'),
('Pushpa 2: The Rule', 'Continuation of the rise of a laborer in the world of red sandalwood smuggling.', 180, 'Telugu', '2024-12-06', 'Action', 'Sukumar', 'https://m.media-amazon.com/images/M/MV5BNGZlNTFlOWMtMzUwNC00ZDdhLTk0MWUtOGZjYzFlOTBmNDdhXkEyXkFqcGdeQXVyMTUyNjIwMDEw._V1_.jpg', 'Tollywood'),
('Kanguva', 'A historical action drama spanning different time periods.', 165, 'Telugu', '2024-07-10', 'Action', 'Siva', 'https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/kanguva-et00331565-1717158429.jpg', 'Tollywood');

-- Insert sample theaters
INSERT INTO theaters (name, location, total_screens)
VALUES 
('Cineplex', 'Downtown', 5),
('Movie Paradise', 'Uptown', 8),
('FilmHouse', 'West End', 6);

-- Insert sample screens
INSERT INTO screens (theater_id, screen_number, total_seats)
VALUES 
(1, 1, 150),
(1, 2, 120),
(1, 3, 180),
(2, 1, 200),
(2, 2, 150),
(3, 1, 160);

-- Insert sample showtimes
INSERT INTO showtimes (movie_id, screen_id, start_time, end_time, price)
VALUES 
(1, 1, '2024-06-15 10:00:00', '2024-06-15 12:46:00', 12.99),
(1, 2, '2024-06-15 13:30:00', '2024-06-15 16:16:00', 12.99),
(2, 3, '2024-06-15 11:00:00', '2024-06-15 12:55:00', 10.99),
(2, 4, '2024-06-15 14:30:00', '2024-06-15 16:25:00', 10.99),
(3, 5, '2024-06-15 12:00:00', '2024-06-15 14:06:00', 11.99),
(4, 6, '2024-06-15 15:00:00', '2024-06-15 17:25:00', 11.99),
(5, 1, '2024-06-15 18:00:00', '2024-06-15 20:30:00', 14.99),
(6, 2, '2024-06-15 19:00:00', '2024-06-15 22:00:00', 13.99),
(7, 3, '2024-06-15 20:00:00', '2024-06-15 22:45:00', 13.99),
(8, 4, '2024-06-15 18:30:00', '2024-06-15 21:30:00', 14.99),
(9, 5, '2024-06-15 19:30:00', '2024-06-15 22:15:00', 13.99),
(10, 6, '2024-06-15 20:30:00', '2024-06-15 23:15:00', 14.99);

-- Use booking_db and create tables
USE booking_db;

CREATE TABLE IF NOT EXISTS seats (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    screen_id BIGINT NOT NULL,
    row_name CHAR(1) NOT NULL,
    seat_number INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    showtime_id BIGINT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    booking_status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS booking_seats (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    seat_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

CREATE TABLE IF NOT EXISTS tickets (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    qr_code VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

-- Insert sample seats for Screen 1
INSERT INTO seats (screen_id, row_name, seat_number)
SELECT 1, row_letter, seat_num
FROM (
    SELECT 'A' AS row_letter UNION SELECT 'B' UNION SELECT 'C' UNION SELECT 'D' UNION SELECT 'E'
) AS rows
CROSS JOIN (
    SELECT 1 AS seat_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) AS seats;

-- Insert sample seats for other screens (similar pattern)
INSERT INTO seats (screen_id, row_name, seat_number)
SELECT 2, row_letter, seat_num
FROM (
    SELECT 'A' AS row_letter UNION SELECT 'B' UNION SELECT 'C' UNION SELECT 'D'
) AS rows
CROSS JOIN (
    SELECT 1 AS seat_num UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
    UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
) AS seats;

-- Use payment_db and create tables
USE payment_db;

CREATE TABLE IF NOT EXISTS payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_id VARCHAR(100),
    payment_status VARCHAR(20) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Use admin_db and create tables
USE admin_db;

CREATE TABLE IF NOT EXISTS configurations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    config_key VARCHAR(50) NOT NULL UNIQUE,
    config_value VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert sample configurations
INSERT INTO configurations (config_key, config_value)
VALUES 
('BASE_TICKET_PRICE', '10.99'),
('PREMIUM_SEAT_MARKUP', '5.00'),
('WEEKEND_MARKUP', '2.00'),
('TAX_RATE', '0.08');