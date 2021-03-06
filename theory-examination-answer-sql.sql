CREATE DATABASE theory_examination

USE theory_examination

CREATE TABLE Users(
	UserId CHAR(5) NOT NULL,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	School VARCHAR(255) NOT NULL,
	[Address] VARCHAR(255) NOT NULL,
	Email VARCHAR(255) NOT NULL,
	PhoneNumber CHAR(12) NOT NULL,
	[Location] VARCHAR(255) NOT NULL,
	DateOfBirth DATE NOT NULL,
	Gender VARCHAR(6) NOT NULL,
	CONSTRAINT UsersPK PRIMARY KEY(UserId),
	CONSTRAINT CheckUserId CHECK(UserId LIKE 'US[0-9][0-9][0-9]'),
	CONSTRAINT CheckGender CHECK(Gender LIKE 'Male' or Gender LIKE 'Female')
)

CREATE TABLE Friends(
	FriendId CHAR(5) NOT NULL,
	UserId CHAR(5) NOT NULL,
	CONSTRAINT CheckFriendId CHECK(FriendId LIKE 'FR[0-9][0-9][0-9]'),
	CONSTRAINT FriendsFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Pages(
	PageId CHAR(5) NOT NULL,
	PageName VARCHAR(255) NOT NULL,
	PageContent VARCHAR(255) NOT NULL,
	CONSTRAINT CheckPageId CHECK(PageId LIKE 'PA[0-9][0-9][0-9]'),
	CONSTRAINT PagesPK PRIMARY KEY(PageId)
)

CREATE TABLE PageLikes(
	UserId CHAR(5) NOT NULL,
	PageId CHAR(5) NOT NULL,
	CONSTRAINT PageLikesPK PRIMARY KEY(UserId, PageId),
	CONSTRAINT PageLikesFirstFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT PageLikesSecondFK FOREIGN KEY(PageId) REFERENCES Pages(PageId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Posts(
	PostId CHAR(5) NOT NULL,
	UserId CHAR(5) NOT NULL,
	PostDate DATE NOT NULL,
	PostContent VARCHAR(255) NOT NULL,
	CONSTRAINT CheckPostId CHECK(PostId LIKE 'PO[0-9][0-9][0-9]'),
	CONSTRAINT PostsPK PRIMARY KEY(PostId),
	CONSTRAINT PostsFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Comments(
	CommentId CHAR(5) NOT NULL,
	PostId CHAR(5) NOT NULL,
	UserId CHAR(5) NOT NULL,
	CommentDate DATE NOT NULL,
	CommentContent VARCHAR(255) NOT NULL,
	CONSTRAINT CheckCommentId CHECK(CommentId LIKE 'CO[0-9][0-9][0-9]'),
	CONSTRAINT CommentsPK PRIMARY KEY(CommentId),
	CONSTRAINT CommentsFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CommentsSecondtFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE Photos(
	PhotoId CHAR(5) NOT NULL,
	PostId CHAR(5) NOT NULL,
	ImageContent VARCHAR(255) NOT NULL,
	CONSTRAINT PhotosPK PRIMARY KEY(PhotoId),
	CONSTRAINT PhotosFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE, 
	CONSTRAINT CheckPhotoId CHECK(PhotoId LIKE 'PO[0-9][0-9][0-9]')
)

CREATE TABLE Shares(
	PostId CHAR(5) NOT NULL,
	UserId CHAR(5) NOT NULL,
	CONSTRAINT SharesFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT SharesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE PostLikes(
	PostId CHAR(5) NOT NULL,
	UserId CHAR(5) NOT NULL,
	CONSTRAINT PostLikesFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT PostLikesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE CommentLikes(
	UserId CHAR(5) NOT NULL,
	CommentId CHAR(5) NOT NULL,
	CONSTRAINT CommentLikesFirstFK FOREIGN KEY(CommentId) REFERENCES Comments(CommentId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CommentLikesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)