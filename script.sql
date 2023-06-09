USE [master]
GO
/****** Object:  Database [TestTaskDB]    Script Date: 28.03.2023 3:46:14 ******/
CREATE DATABASE [TestTaskDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TestTaskDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestTaskDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TestTaskDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\TestTaskDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [TestTaskDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TestTaskDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TestTaskDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TestTaskDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TestTaskDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TestTaskDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TestTaskDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TestTaskDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TestTaskDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TestTaskDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TestTaskDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TestTaskDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TestTaskDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TestTaskDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TestTaskDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TestTaskDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TestTaskDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TestTaskDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TestTaskDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TestTaskDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TestTaskDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TestTaskDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TestTaskDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TestTaskDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TestTaskDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TestTaskDB] SET  MULTI_USER 
GO
ALTER DATABASE [TestTaskDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TestTaskDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TestTaskDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TestTaskDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TestTaskDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TestTaskDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [TestTaskDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [TestTaskDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [TestTaskDB]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Amount] [float] NOT NULL,
	[PaymentAmount] [float] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ReplenishmentID] [int] NOT NULL,
	[Amount] [float] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Replenishments]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Replenishments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NOT NULL,
	[Amount] [float] NOT NULL,
	[Remains] [float] NOT NULL,
 CONSTRAINT [PK_Replenishments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([ID], [Date], [Amount], [PaymentAmount]) VALUES (5, CAST(N'2023-05-25' AS Date), 100, 100)
INSERT [dbo].[Orders] ([ID], [Date], [Amount], [PaymentAmount]) VALUES (6, CAST(N'2023-05-25' AS Date), 100, 100)
INSERT [dbo].[Orders] ([ID], [Date], [Amount], [PaymentAmount]) VALUES (7, CAST(N'0001-01-01' AS Date), 50, 0)
INSERT [dbo].[Orders] ([ID], [Date], [Amount], [PaymentAmount]) VALUES (8, CAST(N'2023-03-26' AS Date), 200, 50)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([ID], [OrderID], [ReplenishmentID], [Amount]) VALUES (21, 6, 4, 100)
INSERT [dbo].[Payments] ([ID], [OrderID], [ReplenishmentID], [Amount]) VALUES (22, 8, 6, 50)
INSERT [dbo].[Payments] ([ID], [OrderID], [ReplenishmentID], [Amount]) VALUES (23, 5, 2, 100)
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Replenishments] ON 

INSERT [dbo].[Replenishments] ([ID], [Date], [Amount], [Remains]) VALUES (2, CAST(N'2023-03-21' AS Date), 200, 100)
INSERT [dbo].[Replenishments] ([ID], [Date], [Amount], [Remains]) VALUES (4, CAST(N'2023-03-21' AS Date), 1000, 900)
INSERT [dbo].[Replenishments] ([ID], [Date], [Amount], [Remains]) VALUES (5, CAST(N'0001-01-01' AS Date), 100, 100)
INSERT [dbo].[Replenishments] ([ID], [Date], [Amount], [Remains]) VALUES (6, CAST(N'2023-03-26' AS Date), 50, 0)
SET IDENTITY_INSERT [dbo].[Replenishments] OFF
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Orders_PaymentAmount]  DEFAULT ((0)) FOR [PaymentAmount]
GO
ALTER TABLE [dbo].[Replenishments] ADD  CONSTRAINT [DF_Replenishments_Date]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Replenishments] ADD  CONSTRAINT [DF_Replenishments_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([ID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Replenishments] FOREIGN KEY([ReplenishmentID])
REFERENCES [dbo].[Replenishments] ([ID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Replenishments]
GO
/****** Object:  Trigger [dbo].[Order_INSERT]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Order_INSERT]
ON [dbo].[Orders]
AFTER INSERT
AS
UPDATE Orders SET  Date = getdate() WHERE Id = (SELECT Id FROM inserted)
GO
ALTER TABLE [dbo].[Orders] ENABLE TRIGGER [Order_INSERT]
GO
/****** Object:  Trigger [dbo].[Products_INSERT]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Products_INSERT]
ON [dbo].[Payments]
INSTEAD OF INSERT
AS
BEGIN
	SET NOCOUNT OFF;
	DECLARE @Ost INT
	SELECT @Ost = (SELECT Amount FROM Orders WHERE ID = (SELECT OrderID FROM inserted)) - (SELECT PaymentAmount FROM Orders WHERE ID = (SELECT OrderID FROM inserted))

	DECLARE @X INT
	SELECT @X = (SELECT Remains FROM Replenishments WHERE ID = (SELECT ReplenishmentID FROM inserted))
	IF @Ost!=0
	BEGIN
			IF @X!=0
			BEGIN
				IF @X <= @Ost
					BEGIN
						INSERT INTO Payments (OrderID, Amount,ReplenishmentID) VALUES ((SELECT OrderID FROM inserted),@X,(SELECT ReplenishmentID FROM inserted))
						UPDATE Orders SET PaymentAmount = PaymentAmount + @X WHERE Id = (SELECT OrderID FROM inserted)
						UPDATE Replenishments SET Remains = 0 WHERE Id = (SELECT ReplenishmentID FROM inserted)
		
					END;
				ELSE
					BEGIN
						INSERT INTO Payments (OrderID, Amount,ReplenishmentID) VALUES ((SELECT OrderID FROM inserted),@Ost,(SELECT ReplenishmentID FROM inserted))
						UPDATE Replenishments SET Remains = Remains - @Ost WHERE Id = (SELECT ReplenishmentID FROM inserted)
						UPDATE Orders SET PaymentAmount = Amount WHERE Id = (SELECT OrderID FROM inserted)		
					END;
			END;
	
	END;
	select ID from [dbo].Payments where @@ROWCOUNT > 0 and ID = scope_identity();
END;	
GO
ALTER TABLE [dbo].[Payments] ENABLE TRIGGER [Products_INSERT]
GO
/****** Object:  Trigger [dbo].[Products_INSERT_UPDATE]    Script Date: 28.03.2023 3:46:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Products_INSERT_UPDATE]
ON [dbo].[Replenishments]
AFTER INSERT
AS
UPDATE Replenishments
SET Remains = Amount, Date = getdate()
WHERE Id = (SELECT Id FROM inserted)
GO
ALTER TABLE [dbo].[Replenishments] ENABLE TRIGGER [Products_INSERT_UPDATE]
GO
USE [master]
GO
ALTER DATABASE [TestTaskDB] SET  READ_WRITE 
GO
