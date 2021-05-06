CREATE DATABASE theory_examination

USE theory_examination

CREATE TABLE Users(
	UserId CHAR(5),
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	School VARCHAR(255),
	[Address] VARCHAR(255),
	Email VARCHAR(255),
	PhoneNumber CHAR(12),
	[Location] VARCHAR(255),
	DateOfBirth DATE,
	Gender CHAR(1),
	CONSTRAINT UsersPK PRIMARY KEY(UserId),
	CONSTRAINT CheckUserId CHECK(UserId LIKE 'US[0-9][0-9][0-9]'),
	CONSTRAINT CheckGender CHECK(Gender LIKE 'M' or Gender LIKE 'F')
)

CREATE TABLE Friends(
	FriendId CHAR(5),
	UserId CHAR(5),
	CONSTRAINT CheckFriendId CHECK(FriendId LIKE 'FR[0-9][0-9][0-9]'),
	CONSTRAINT FriendsFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Pages(
	PageId CHAR(5),
	PageName VARCHAR(255),
	PageContent VARCHAR(255),
	CONSTRAINT CheckPageId CHECK(PageId LIKE 'PA[0-9][0-9][0-9]'),
	CONSTRAINT PagesPK PRIMARY KEY(PageId)
)

CREATE TABLE PageLikes(
	UserId CHAR(5),
	PageId CHAR(5),
	CONSTRAINT PageLikesPK PRIMARY KEY(UserId, PageId),
	CONSTRAINT PageLikesFirstFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT PageLikesSecondFK FOREIGN KEY(PageId) REFERENCES Pages(PageId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Posts(
	PostId CHAR(5),
	UserId CHAR(5),
	PostDate DATE,
	PostContent VARCHAR(255),
	CONSTRAINT CheckPostId CHECK(PostId LIKE 'PO[0-9][0-9][0-9]'),
	CONSTRAINT PostsPK PRIMARY KEY(PostId),
	CONSTRAINT PostsFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE TABLE Comments(
	CommentId CHAR(5),
	PostId CHAR(5),
	UserId CHAR(5),
	CommentDate DATE,
	CommentContent VARCHAR(255),
	CONSTRAINT CheckCommentId CHECK(CommentId LIKE 'CO[0-9][0-9][0-9]'),
	CONSTRAINT CommentsPK PRIMARY KEY(CommentId),
	CONSTRAINT CommentsFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CommentsSecondtFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE Photos(
	PhotoId CHAR(5),
	PostId CHAR(5),
	ImageContent VARCHAR(255),
	CONSTRAINT PhotosPK PRIMARY KEY(PhotoId),
	CONSTRAINT PhotosFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE, 
	CONSTRAINT CheckPhotoId CHECK(PhotoId LIKE 'PO[0-9][0-9][0-9]')
)

CREATE TABLE Shares(
	PostId CHAR(5),
	UserId CHAR(5),
	CONSTRAINT SharesFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT SharesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE PostLikes(
	PostId CHAR(5),
	UserId CHAR(5),
	CONSTRAINT PostLikesFirstFK FOREIGN KEY(PostId) REFERENCES Posts(PostId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT PostLikesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE CommentLikes(
	UserId CHAR(5),
	CommentId CHAR(5),
	CONSTRAINT CommentLikesFirstFK FOREIGN KEY(CommentId) REFERENCES Comments(CommentId) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CommentLikesSecondFK FOREIGN KEY(UserId) REFERENCES Users(UserId) ON UPDATE NO ACTION ON DELETE NO ACTION
)