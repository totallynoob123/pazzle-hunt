CREATE TABLE IF NOT EXISTS hint_usage(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  team_id INTEGER NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  puzzle_id INTEGER NOT NULL REFERENCES puzzles(id) ON DELETE CASCADE,
  hint_order INTEGER NOT NULL,
  used_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(team_id,puzzle_id,hint_order)
);
CREATE INDEX IF NOT EXISTS hint_usage_team_date ON hint_usage(team_id,used_at);

