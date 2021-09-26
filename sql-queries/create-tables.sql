CREATE TABLE games (
	game_id NUMERIC PRIMARY KEY UNIQUE,
	season NUMERIC,
	week NUMERIC,
	game_date TEXT,
	game_time_eastern TEXT,
	home_team_abbr TEXT,
	away_team_abbr TEXT
);

CREATE TABLE players (
	nfl_id NUMERIC PRIMARY KEY,
	height TEXT,
	weight NUMERIC,
	birth_date TEXT,
	college_name TEXT,
	position TEXT,
	display_name TEXT
);

CREATE TABLE plays (
	game_id NUMERIC,
	play_id NUMERIC,
	play_description TEXT,
	quarter NUMERIC,
	down NUMERIC,
	yards_to_go NUMERIC,
	possession_team TEXT,
	special_teams_play_type TEXT,
	special_teams_play_result TEXT,
	kicker_id NUMERIC,
	returner_id TEXT,
	kick_blocker_id NUMERIC,
	yardline_side TEXT,
	yardline_number NUMERIC,
	game_clock TEXT,
	penalty_codes TEXT,
	penalty_jersey_number TEXT,
	penalty_yards NUMERIC,
	pre_snap_home_score NUMERIC,
	pre_snap_away_score NUMERIC,
	pass_result TEXT,
	kick_length NUMERIC,
	kick_return_yardage NUMERIC,
	play_result NUMERIC,
	absolute_yardline_number NUMERIC,
	FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (kick_blocker_id) REFERENCES players (nfl_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (kicker_id) REFERENCES players (nfl_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tracking (
	time TEXT,
	x NUMERIC,
	y NUMERIC,
	speed NUMERIC,
	acceleration NUMERIC,
	distance_since_last_obs NUMERIC,
	player_orientation NUMERIC,
	direction_of_motion NUMERIC,
	event TEXT,
	nfl_id NUMERIC,
	display_name TEXT,
	jersey_number NUMERIC,
	position TEXT,
	team TEXT,
	frame_id NUMERIC,
	game_id NUMERIC,
	play_id NUMERIC,
	play_direction TEXT,
	FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (play_id) REFERENCES plays (play_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (nfl_id) REFERENCES players (nfl_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE pff (
	game_id NUMERIC,
	play_id NUMERIC,
	snap_detail TEXT,
	snap_time NUMERIC,
	operation_time NUMERIC,
	hang_time NUMERIC,
	kick_type TEXT,
	kick_direction_intended TEXT,
	kick_direction_actual TEXT,
	return_direction_intended TEXT,
	return_direction_actual TEXT,
	missed_tacklers TEXT,
	assist_tacklers TEXT,
	tacklers TEXT,
	kickoff_return_formation TEXT,
	gunners TEXT,
	punt_rushers TEXT,
	special_teams_safties TEXT,
	vises TEXT,
	kick_contact_type TEXT,
	FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (play_id) REFERENCES plays (play_id) ON DELETE CASCADE ON UPDATE CASCADE
);