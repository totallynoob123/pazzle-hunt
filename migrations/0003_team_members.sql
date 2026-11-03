ALTER TABLE teams ADD COLUMN team_code TEXT;
ALTER TABLE teams ADD COLUMN banned INTEGER NOT NULL DEFAULT 0;
UPDATE teams SET team_code=upper(substr(hex(randomblob(8)),1,8)) WHERE team_code IS NULL;
CREATE UNIQUE INDEX teams_team_code_unique ON teams(team_code);
CREATE TABLE team_members(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  team_id INTEGER NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  email TEXT NOT NULL UNIQUE,
  verified INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE verification_tokens(
  token_hash TEXT PRIMARY KEY,
  member_id INTEGER NOT NULL REFERENCES team_members(id) ON DELETE CASCADE,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT OR IGNORE INTO team_members(team_id,email,verified) SELECT id,email,1 FROM teams;
INSERT OR IGNORE INTO teams(team_name,email,password_hash,role,level,leaderboard_visible,team_code,banned)
VALUES('test','test','5f8c562dc3fc28c0bc3afb6fb8984df5:6c8d0feab6f975ff9251eefd157c88c7551b5901f5192edc0d38d1823ac0bd69','team',1,0,'TESTTEAM',0);
INSERT OR IGNORE INTO team_members(team_id,email,verified) SELECT id,'test',1 FROM teams WHERE team_name='test';
