-- Create tblDepartment table with departments
CREATE TABLE [dbo].[tblDepartment](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	to tblDepartment
INSERT INTO [dbo].[tblDepartment] (DepartmentName)
VALUES
('Software Developer'),
('SR. Software Developer'),
('Module Lead'),
('Team Lead'),
('Project Manager'),
('Manager'),
('CEO'),
('HR');

-- Create tblEmployee table with employee details and foreign key to tblDepartment
CREATE TABLE [dbo].[tblEmployee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	  NULL,
	  NULL,
	  NULL,
	[Y	[Sales]int] NULe_DeptID] DEFAULT (2),
	CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
		REFERENCES [dbo].[tblDepartment] ([ID])
);

-- Insert employee data into tblEmployee
INSERT INTO tblEmployee (FirstName, LastName, Education, YearlyIncome, Sales, DeptID)
VALUES 
('John', 'Yang', 'Bachelors', 90000, 3578.27, 1),
('Tutorial', 'Gateway', 'Masters', 80000, 3399.99, 2),
('Ruben', 'Torres', 'Partial College', 70000, 699.98, 2),
('Christy', 'Zhu', 'Bachelors', 80000, 3078.27, 2),
('Rob', 'Huang', 'High School', 60000, 2319.99, 2),
('John', 'Ruiz', 'Bachelors', 70000, 539.99, 3),
('SQL', 'Tutorial', 'Masters Degree', 120000, 2234.9, 3),
('Christy', 'Mehta', 'Partial High School', 45000, 24.99, 3),
('Rob', 'Verhoff', 'Partial High School', 45000, 24.99, 3),
('Christy', 'Carlson', 'Graduate Degree', 90000, 2234.9, 3),
('Gail', 'Erickson', 'Education', 75000, 4968.53, 4),
('Barry', 'Johnson', 'Education', 85000, 59.53, 4),
('Peter', 'Krebs', 'Graduate Degree', 90000, 59.53, 4),
('Greg', 'Alderson', 'Partial High School', 45000, 2320.49, NULL);

-- Remove foreign key constraint to modify it
ALTER TABLE [dbo].[tblEmployee]  
DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

-- Add foreign key with NO ACTION on update/delete
ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE NO ACTION ON DELETE NO ACTION;

-- Delete department with ID = 1 (Software Developer)
DELETE FROM [tblDepartment]
WHERE ID = 1;

-- Remove the previous foreign key constraint
ALTER TABLE [dbo].[tblEmployee]  
DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

-- Add foreign key with SET DEFAULT on update/delete
ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE SET DEFAULT ON DELETE SET DEFAULT;

-- Delete department with ID = 1 (Software Developer)
DELETE FROM [tblDepartment]
WHERE ID = 1;

-- Show employees after updates
SELECT * FROM tblEmployee;

-- Remove the previous foreign key constraint
ALTER TABLE [dbo].[tblEmployee]  
DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

-- Add foreign key with SET NULL on update/delete
ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE SET NULL ON DELETE SET NULL;

-- Delete department with ID = 2 (SR. Software Developer)
DELETE FROM [tblDepartment]
WHERE ID = 2;

-- Remove the previous foreign key constraint
ALTER TABLE [dbo].[tblEmployee]  
DROP CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID];

-- Add foreign key with CASCADE on update/delete
ALTER TABLE [dbo].[tblEmployee]  
ADD CONSTRAINT [FK_tblDepartment_tblEmployee_DeptID] FOREIGN KEY([DeptID])
        REFERENCES [dbo].[tblDepartment] ([ID])
        ON UPDATE CASCADE ON DELETE CASCADE;

-- Delete department with ID = 2 (SR. Software Developer)
DELETE FROM [tblDepartment]
WHERE ID = 2;
