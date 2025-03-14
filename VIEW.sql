CREATE DATABASE dbEMIT;



CREATE TABLE dbo.tblUser(
    userID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    position NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL, 
    phoneNumber NVARCHAR(15),
    dateCreated DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    dateUpdated DATETIME2(0)
);


CREATE TABLE dbo.tblUserPassword(
    userPasswordID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    userID INT NOT NULL FOREIGN KEY REFERENCES dbo.tblUser(userID),
    password NVARCHAR(256) NOT NULL,
    dateCreated DATETIME2(0) NOT NULL DEFAULT GETDATE(),
    dateUpdated DATETIME2(0)
);
GO


CREATE TABLE dbo.tblUser_History (
    userPasswordHistoryID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    userID INT NOT NULL FOREIGN KEY REFERENCES dbo.tblUser(userID),
    passwordHash VARBINARY(256) NOT NULL, 
    dateChanged DATETIME2(0) NOT NULL DEFAULT GETDATE()  -- Password change date
);

-- Create the view to get user details
CREATE VIEW dbo.vwUserDetails AS
SELECT 
    u.userID,
    u.name,
    u.position,
    u.email,
    u.phoneNumber,
    u.dateCreated AS UserCreatedDate,
    u.dateUpdated AS UserUpdatedDate,
    p.password AS CurrentPassword,
    p.dateCreated AS PasswordCreatedDate,
    p.dateUpdated AS PasswordUpdatedDate,
    h.passwordHash AS LastPasswordHash,
    h.dateChanged AS LastPasswordChangeDate
FROM 
    dbo.tblUser u
LEFT JOIN 
    dbo.tblUserPassword p ON u.userID = p.userID
LEFT JOIN 
    dbo.tblUser_History h ON u.userID = h.userID
ORDER BY 
    u.userID;


SELECT * 
FROM dbo.vwUserDetails;
