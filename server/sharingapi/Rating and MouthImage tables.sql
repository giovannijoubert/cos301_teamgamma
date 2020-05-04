CREATE TABLE Rating(
	rating_id INT(11) NOT NULL AUTO_INCREMENT,
	value TINYINT UNSIGNED,
	user_id INT(11),
	mouthpack_id INT(11),
	PRIMARY KEY (rating_id),
	--FOREIGN KEY (user_id) REFERENCES User(user_id),       Didn't implement JD Gratz
	FOREIGN KEY (mouthpack_id) REFERENCES Mouthpack(mouthpack_id)
);

CREATE TABLE MouthImage(
	image_id INT(11) NOT NULL AUTO_INCREMENT,
	mouthpack_id INT(11),
	image_URL VARCHAR(100),
	PRIMARY KEY (image_id),
	FOREIGN KEY (mouthpack_id) REFERENCES Mouthpack(mouthpack_id)
);