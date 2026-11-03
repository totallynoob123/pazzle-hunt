PRAGMA foreign_keys=ON;
CREATE TABLE teams(id INTEGER PRIMARY KEY AUTOINCREMENT,team_name TEXT NOT NULL UNIQUE,email TEXT NOT NULL UNIQUE,password_hash TEXT NOT NULL,role TEXT NOT NULL DEFAULT 'team' CHECK(role IN('team','admin')),level INTEGER NOT NULL DEFAULT 1 CHECK(level BETWEEN 1 AND 6),leaderboard_visible INTEGER NOT NULL DEFAULT 1,created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE puzzles(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,level INTEGER NOT NULL CHECK(level BETWEEN 1 AND 6),category TEXT NOT NULL DEFAULT 'Puzzle',body TEXT NOT NULL DEFAULT '',answer TEXT NOT NULL,solution TEXT NOT NULL DEFAULT '',published INTEGER NOT NULL DEFAULT 1,sort_order INTEGER NOT NULL DEFAULT 0);
CREATE TABLE hints(id INTEGER PRIMARY KEY AUTOINCREMENT,puzzle_id INTEGER NOT NULL REFERENCES puzzles(id) ON DELETE CASCADE,hint_order INTEGER NOT NULL,hint_text TEXT NOT NULL,UNIQUE(puzzle_id,hint_order));
CREATE TABLE guesses(id INTEGER PRIMARY KEY AUTOINCREMENT,team_id INTEGER NOT NULL REFERENCES teams(id) ON DELETE CASCADE,puzzle_id INTEGER NOT NULL REFERENCES puzzles(id) ON DELETE CASCADE,guess TEXT NOT NULL,correct INTEGER NOT NULL DEFAULT 0,guessed_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE solves(id INTEGER PRIMARY KEY AUTOINCREMENT,team_id INTEGER NOT NULL REFERENCES teams(id) ON DELETE CASCADE,puzzle_id INTEGER NOT NULL REFERENCES puzzles(id) ON DELETE CASCADE,solved_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,UNIQUE(team_id,puzzle_id));
CREATE TABLE settings(key TEXT PRIMARY KEY,value TEXT NOT NULL);
CREATE TABLE hint_usage(id INTEGER PRIMARY KEY AUTOINCREMENT,team_id INTEGER NOT NULL REFERENCES teams(id) ON DELETE CASCADE,puzzle_id INTEGER NOT NULL REFERENCES puzzles(id) ON DELETE CASCADE,hint_order INTEGER NOT NULL,used_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,UNIQUE(team_id,puzzle_id,hint_order));
CREATE INDEX hint_usage_team_date ON hint_usage(team_id,used_at);
INSERT INTO settings(key,value) VALUES('introduction','Pazzle is a collaborative puzzle hunt for Lakeside teams. Solve each set, share ideas with your teammates, and climb the leaderboard.');
-- Puzzle answers, solutions, and hints are intentionally not stored in Git.
-- Add them directly through the authenticated admin tools or the production database.

