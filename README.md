# Quest Complete Database Setup Guide

## Prerequisites
- PostgreSQL installed and running on your system
- Command line access to run PostgreSQL commands

## Initial Setup
- First, ensure PostgreSQL is installed on your system. You can check if it's running with:
```bash
sudo systemctl status postgresql
```

- If not already running, start it:
```bash
sudo systemctl start postgresql
```
- Create a .env file in the root directory of your project with the following content:
```env
DATABASE_URL=postgresql://postgres:password@localhost:5432/database_name

PORT=XxXx
```
### Create the application database:
```bash
sudo -u postgres createdb quest_complete
```

### Database Schema
- The application uses a games table to track completed games. Create the table using:
```bash
sudo -u postgres psql -d quest_complete -c "
CREATE TABLE IF NOT EXISTS games (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  platform TEXT NOT NULL,
  genre TEXT NOT NULL,
  release_date TEXT NOT NULL,
  igdb_id INTEGER NOT NULL,
  cover_url TEXT NOT NULL,
  completion_date TEXT NOT NULL,
  rating INTEGER,
  review TEXT,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL,
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);"
```

### Sample Data
-   Populate the database with initial game data:
```bash
sudo -u postgres psql -d quest_complete -c "
INSERT INTO games (
  id, title, platform, genre, release_date, igdb_id, 
  cover_url, completion_date, rating, review, created_at, updated_at
) VALUES (
  'game-1', 
  'The Legend of Zelda: Breath of the Wild', 
  'Switch', 
  'Action Adventure', 
  '2017-03-03', 
  7346, 
  'https://images.igdb.com/igdb/image/upload/t_cover_big/co3p2d.jpg', 
  '2023-09-15', 
  95, 
  'Un des meilleurs jeux de tous les temps!', 
  NOW(), 
  NOW()
), (
  'game-2', 
  'Hades', 
  'PC', 
  'Roguelike', 
  '2020-09-17', 
  89996, 
  'https://images.igdb.com/igdb/image/upload/t_cover_big/co2g63.jpg', 
  '2024-01-05', 
  NULL, 
  NULL, 
  NOW(), 
  NOW()
), (
  'game-3',
  'Uncharted 4: A Thief''s End',
  'PS4',
  'Action Adventure',
  '2016-05-10',
  7331,
  'https://images.igdb.com/igdb/image/upload/t_cover_big/co1r7h.jpg',
  '2022-08-15',
  93,
  'Une aventure cinématographique exceptionnelle avec des séquences d''action incroyables',
  NOW(),
  NOW()
), (
  'game-4',
  'Red Dead Redemption 2',
  'PS4',
  'Action Adventure',
  '2018-10-26',
  25076,
  'https://images.igdb.com/igdb/image/upload/t_cover_big/co1q1f.jpg',
  '2023-02-20',
  95,
  'Un chef-d''œuvre du monde ouvert avec une histoire captivante',
  NOW(),
  NOW()
), (
  'game-5',
  'God of War',
  'PS4',
  'Action Adventure',
  '2018-04-20',
  19560,
  'https://images.igdb.com/igdb/image/upload/t_cover_big/co1tmu.jpg',
  '2023-06-10',
  94,
  'Une réinvention parfaite de la franchise avec un lien père-fils émouvant',
  NOW(),
  NOW()
);"
```

### Running the Application
-  Once the database is set up, you can run the application:
```bash
 dune exec quest_complete --watch
```

### Verifying the Setup
-  You can check if your database has been correctly populated:
```bash
sudo -u postgres psql -d quest_complete -c "SELECT id, title FROM games;"
```


