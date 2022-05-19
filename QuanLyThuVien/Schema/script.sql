USE [master]
GO
/****** Object:  Database [QLTV]    Script Date: 5/20/2022 1:34:37 AM ******/
CREATE DATABASE [QLTV]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLTV', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLTV.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLTV_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\QLTV_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QLTV] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLTV].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLTV] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLTV] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLTV] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLTV] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLTV] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLTV] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLTV] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLTV] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLTV] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLTV] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLTV] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLTV] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLTV] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLTV] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLTV] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLTV] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLTV] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLTV] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLTV] SET RECOVERY FULL 
GO
ALTER DATABASE [QLTV] SET  MULTI_USER 
GO
ALTER DATABASE [QLTV] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLTV] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLTV] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLTV] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLTV] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLTV] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLTV', N'ON'
GO
ALTER DATABASE [QLTV] SET QUERY_STORE = OFF
GO
USE [QLTV]
GO
/****** Object:  User [u_librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE USER [u_librarian] FOR LOGIN [u_librarian] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [sa_qltv]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE USER [sa_qltv] FOR LOGIN [sa_qltv] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [reader_manager]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE ROLE [reader_manager]
GO
/****** Object:  DatabaseRole [librarian_manager]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE ROLE [librarian_manager]
GO
/****** Object:  DatabaseRole [librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE ROLE [librarian]
GO
/****** Object:  DatabaseRole [book_manager]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE ROLE [book_manager]
GO
ALTER ROLE [librarian] ADD MEMBER [u_librarian]
GO
ALTER ROLE [librarian_manager] ADD MEMBER [u_librarian]
GO
ALTER ROLE [reader_manager] ADD MEMBER [u_librarian]
GO
ALTER ROLE [db_owner] ADD MEMBER [u_librarian]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [u_librarian]
GO
ALTER ROLE [db_owner] ADD MEMBER [sa_qltv]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [librarian_manager]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[Username] [nvarchar](50) NOT NULL,
	[PasswordDigest] [nvarchar](max) NOT NULL,
	[Enable] [bit] NOT NULL,
	[UserableId] [nchar](10) NOT NULL,
	[UserableType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[Id] [nchar](10) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Sex] [bit] NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Birthday] [date] NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [nchar](10) NOT NULL,
	[Size] [smallint] NOT NULL,
	[Lending] [bit] NOT NULL,
	[Notes] [varchar](max) NOT NULL,
	[Status] [smallint] NOT NULL,
	[BookTitleISBN] [nchar](13) NOT NULL,
	[CaseId] [bigint] NOT NULL,
	[LibrarianId] [nchar](10) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCase]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCase](
	[Id] [nchar](10) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[Size] [smallint] NOT NULL,
 CONSTRAINT [PK_BookCase] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookCategory]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookCategory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_BookCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookTitle]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTitle](
	[ISBN] [nchar](13) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Pages] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[ReleaseDate] [date] NOT NULL,
	[PublisherId] [nchar](10) NOT NULL,
 CONSTRAINT [PK_BookTitle] PRIMARY KEY CLUSTERED 
(
	[ISBN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookTitle_Author]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTitle_Author](
	[BookTitleISBN] [nchar](13) NOT NULL,
	[AuthorId] [nchar](10) NOT NULL,
 CONSTRAINT [PK_BookTitle_Author] PRIMARY KEY CLUSTERED 
(
	[BookTitleISBN] ASC,
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookTitle_BookCategory]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookTitle_BookCategory](
	[BookTitleISBN] [nchar](13) NOT NULL,
	[BookCategoryId] [bigint] NOT NULL,
 CONSTRAINT [PK_BookTitle_BookCategory] PRIMARY KEY CLUSTERED 
(
	[BookTitleISBN] ASC,
	[BookCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Caze]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Caze](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Number] [bigint] NOT NULL,
	[BookCaseId] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Case_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LendingSlip]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendingSlip](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ReaderId] [nchar](10) NOT NULL,
	[CreatedByLibrarianId] [nchar](10) NOT NULL,
	[CreatedAt] [date] NOT NULL,
 CONSTRAINT [PK_LendingSlip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LendingSlipDetail]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LendingSlipDetail](
	[BookId] [nchar](10) NOT NULL,
	[LendingSlipId] [bigint] NOT NULL,
	[DueBackDate] [datetime] NOT NULL,
	[BookStatus] [smallint] NULL,
	[Notes] [nvarchar](max) NOT NULL,
	[TookBack] [bit] NULL,
	[TookBackAt] [datetime] NULL,
	[TookBackBy] [nchar](10) NULL,
	[Extended] [bit] NULL,
	[ExtendedBy] [nchar](10) NULL,
	[ExtendedAt] [nchar](10) NULL,
 CONSTRAINT [PK_LendingSlipDetail] PRIMARY KEY CLUSTERED 
(
	[BookId] ASC,
	[LendingSlipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Librarian](
	[Id] [nchar](10) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Sex] [bit] NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Librarian] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibraryCard]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryCard](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[EffectiveEndDate] [datetime] NOT NULL,
	[Fee] [money] NOT NULL,
	[ReaderId] [nchar](10) NOT NULL,
	[CreatedBy] [nchar](10) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_LibraryCard] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LiquidatingSlip]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LiquidatingSlip](
	[Id] [bigint] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[CreatedBy] [nchar](10) NOT NULL,
 CONSTRAINT [PK_LiquidatingSlip] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LiquidatingSlipDetail]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LiquidatingSlipDetail](
	[BookId] [nchar](10) NOT NULL,
	[LiquidatingSlipId] [bigint] NOT NULL,
	[Price] [money] NOT NULL,
	[Notes] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[Id] [nchar](10) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reader]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reader](
	[Id] [nchar](10) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Sex] [bit] NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Birthday] [date] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[LibrarianId] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Reader] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([Username], [PasswordDigest], [Enable], [UserableId], [UserableType]) VALUES (N'LB00000014', N'4XGEd+XH4D7roncNefbB72fCrA/Om91Zie9YYfMPmNI=', 1, N'LB00000011', N'Librarian')
GO
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Address], [Sex], [Email], [Birthday]) VALUES (N'AT00000002', N'Anh', N'Nguyễn Minh', N'TP Hồ Chí Minh', 1, N'minhanh@gmail.com', CAST(N'2001-01-01' AS Date))
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Address], [Sex], [Email], [Birthday]) VALUES (N'AT00000003', N'Anh', N'Trần Minh', N'TP Hồ Chí Minh', 0, N'minhanh@gmail.com', CAST(N'2000-06-14' AS Date))
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Address], [Sex], [Email], [Birthday]) VALUES (N'AT00000004', N'Thư', N'Lê Anh', N'TP Hà Nội', 0, N'anhthu@outlook.com', CAST(N'1999-02-01' AS Date))
INSERT [dbo].[Author] ([Id], [FirstName], [LastName], [Address], [Sex], [Email], [Birthday]) VALUES (N'AT00000005', N'Sơn', N'Lê Thanh', N'TP Hải Phòng', 1, N'thanhson@gmail.com', CAST(N'1998-05-17' AS Date))
GO
INSERT [dbo].[Book] ([Id], [Size], [Lending], [Notes], [Status], [BookTitleISBN], [CaseId], [LibrarianId], [CreatedAt]) VALUES (N'BK00000001', 1, 0, N'Notes', 1, N'24254-34-34-2', 2, N'LB00000011', CAST(N'2022-05-17T21:28:59.433' AS DateTime))
INSERT [dbo].[Book] ([Id], [Size], [Lending], [Notes], [Status], [BookTitleISBN], [CaseId], [LibrarianId], [CreatedAt]) VALUES (N'BK00000002', 2, 0, N'Notes', 1, N'99921-57-10-6', 7, N'LB00000011', CAST(N'2022-05-18T14:53:12.027' AS DateTime))
INSERT [dbo].[Book] ([Id], [Size], [Lending], [Notes], [Status], [BookTitleISBN], [CaseId], [LibrarianId], [CreatedAt]) VALUES (N'BK00000003', 1, 0, N'Ghi chu', 1, N'99921-58-10-7', 4, N'LB00000011', CAST(N'2022-05-18T14:53:42.360' AS DateTime))
INSERT [dbo].[Book] ([Id], [Size], [Lending], [Notes], [Status], [BookTitleISBN], [CaseId], [LibrarianId], [CreatedAt]) VALUES (N'BK00000004', 1, 0, N'Note', 1, N'99923-56-10-1', 2, N'LB00000011', CAST(N'2022-05-18T14:54:17.900' AS DateTime))
GO
INSERT [dbo].[BookCase] ([Id], [Description], [Size]) VALUES (N'BC00000001', N'Kệ tạp chí', 1)
INSERT [dbo].[BookCase] ([Id], [Description], [Size]) VALUES (N'BC00000002', N'Kệ sách khoa học', 1)
INSERT [dbo].[BookCase] ([Id], [Description], [Size]) VALUES (N'BC00000003', N'Kệ sách truyện tranh', 1)
INSERT [dbo].[BookCase] ([Id], [Description], [Size]) VALUES (N'BC00000004', N'Kệ sách truyện chữ', 1)
GO
SET IDENTITY_INSERT [dbo].[BookCategory] ON 

INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (6, N'Hài hước')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (1, N'Hành động')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (4, N'Khoa học')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (5, N'Lãng mạn')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (7, N'Nhân văn')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (8, N'Thiếu nhi')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (3, N'Tiểu Thuyết')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (2, N'Trinh Thám')
INSERT [dbo].[BookCategory] ([Id], [Name]) VALUES (9, N'Vật lý')
SET IDENTITY_INSERT [dbo].[BookCategory] OFF
GO
INSERT [dbo].[BookTitle] ([ISBN], [Name], [Pages], [Price], [ReleaseDate], [PublisherId]) VALUES (N'24254-34-34-2', N'Truyền thuyết Sili', 1000, 10000000.0000, CAST(N'2022-05-17' AS Date), N'PB00000001')
INSERT [dbo].[BookTitle] ([ISBN], [Name], [Pages], [Price], [ReleaseDate], [PublisherId]) VALUES (N'99921-57-10-6', N'Tháp Sili', 900, 900000.0000, CAST(N'2022-05-17' AS Date), N'PB00000002')
INSERT [dbo].[BookTitle] ([ISBN], [Name], [Pages], [Price], [ReleaseDate], [PublisherId]) VALUES (N'99921-58-10-7', N'Lịch sử Sili', 1000, 1000000.0000, CAST(N'2022-05-17' AS Date), N'PB00000001')
INSERT [dbo].[BookTitle] ([ISBN], [Name], [Pages], [Price], [ReleaseDate], [PublisherId]) VALUES (N'99923-56-10-1', N'Vịnh Sili', 650, 650000.0000, CAST(N'2022-05-17' AS Date), N'PB00000003')
INSERT [dbo].[BookTitle] ([ISBN], [Name], [Pages], [Price], [ReleaseDate], [PublisherId]) VALUES (N'99924-21-13-8', N'Văn hóa Sili', 789, 789000.0000, CAST(N'2022-05-17' AS Date), N'PB00000004')
GO
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'24254-34-34-2', N'AT00000002')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99921-57-10-6', N'AT00000002')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99921-58-10-7', N'AT00000002')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99921-58-10-7', N'AT00000003')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99923-56-10-1', N'AT00000004')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99924-21-13-8', N'AT00000004')
INSERT [dbo].[BookTitle_Author] ([BookTitleISBN], [AuthorId]) VALUES (N'99924-21-13-8', N'AT00000005')
GO
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'24254-34-34-2', 4)
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'99921-57-10-6', 4)
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'99921-58-10-7', 4)
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'99923-56-10-1', 4)
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'99924-21-13-8', 4)
INSERT [dbo].[BookTitle_BookCategory] ([BookTitleISBN], [BookCategoryId]) VALUES (N'99924-21-13-8', 7)
GO
SET IDENTITY_INSERT [dbo].[Caze] ON 

INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (2, 1, N'BC00000001')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (4, 2, N'BC00000001')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (5, 3, N'BC00000001')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (6, 1, N'BC00000002')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (7, 2, N'BC00000002')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (8, 3, N'BC00000002')
INSERT [dbo].[Caze] ([Id], [Number], [BookCaseId]) VALUES (9, 4, N'BC00000002')
SET IDENTITY_INSERT [dbo].[Caze] OFF
GO
SET IDENTITY_INSERT [dbo].[LendingSlip] ON 

INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (1, N'RD00000001', N'LB00000014', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (2, N'RD00000002', N'LB00000011', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (3, N'RD00000001', N'LB00000014', CAST(N'2022-01-01' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (9, N'RD00000001', N'LB00000011', CAST(N'2022-05-18' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (15, N'RD00000001', N'LB0000014 ', CAST(N'2022-05-18' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (22, N'RD00000001', N'LB00000011', CAST(N'2022-05-18' AS Date))
INSERT [dbo].[LendingSlip] ([Id], [ReaderId], [CreatedByLibrarianId], [CreatedAt]) VALUES (23, N'RD00000001', N'LB00000011', CAST(N'2022-05-18' AS Date))
SET IDENTITY_INSERT [dbo].[LendingSlip] OFF
GO
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 1, CAST(N'2022-05-18T14:51:29.000' AS DateTime), NULL, N'NOte', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 2, CAST(N'2022-05-18T14:52:04.000' AS DateTime), NULL, N'Hello', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 3, CAST(N'2022-05-18T23:52:20.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 9, CAST(N'2022-05-18T15:44:45.300' AS DateTime), 1, N'Note', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 15, CAST(N'2022-05-18T22:51:19.030' AS DateTime), NULL, N'Notes', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 22, CAST(N'2022-05-18T23:26:54.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000001', 23, CAST(N'2022-05-18T23:38:22.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000002', 2, CAST(N'2022-05-18T23:52:44.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000002', 15, CAST(N'2022-05-18T22:51:19.030' AS DateTime), NULL, N'Notes', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000002', 23, CAST(N'2022-05-18T23:38:24.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000003', 1, CAST(N'2022-05-18T15:44:15.000' AS DateTime), NULL, N'NOte', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000003', 23, CAST(N'2022-05-18T23:38:28.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[LendingSlipDetail] ([BookId], [LendingSlipId], [DueBackDate], [BookStatus], [Notes], [TookBack], [TookBackAt], [TookBackBy], [Extended], [ExtendedBy], [ExtendedAt]) VALUES (N'BK00000004', 23, CAST(N'2022-05-18T23:38:31.000' AS DateTime), NULL, N'', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000003', N'Anh', N'Trần Minh', 0, N'96 Man Thiện, phường Hiệp Phú, Tp Thủ Đức , TP Hồ Chí Minh', CAST(N'2001-04-01' AS Date), N'minhanh@gmail.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000004', N'Nhật Quỳnh', N'Nguyên Minh', 0, N'96 Man Thiện, phường Hiệp Phú, TP Thủ Đức, TP Hồ Chí Minh', CAST(N'2001-04-01' AS Date), N'minhnhat@gmail.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000005', N'Tuyết Huỳnh', N'Điệp Lam', 0, N'96 Man Thiện, phường Hiệp Phú, TP Thủ Đức, TP Hồ Chí Minh', CAST(N'2001-04-01' AS Date), N'lamtuyet@outlook.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000006', N'Sơn', N'Diệp Thanh', 1, N'96 Man Thiện, phường Hiệp Phú, TP Thủ Đức, TP Hồ Chí Minh', CAST(N'2001-04-11' AS Date), N'thanhson@outlook.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000009', N'Anh', N'Trần Minh', 0, N'96 Man Thiện, phường Hiệp Phú, TP Thủ Đức, TP Hồ Chí Minh', CAST(N'2001-11-01' AS Date), N'tranminhanh@outlook.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000011', N'Erin', N'Loulai', 0, N'Tháp Sili', CAST(N'2001-07-01' AS Date), N'loulaierin@sili.com')
INSERT [dbo].[Librarian] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email]) VALUES (N'LB00000014', N'Duy Khánh', N'Trần', 1, N'TP Hồ Chí Minh', CAST(N'2022-05-01' AS Date), N'duykhanh@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[LibraryCard] ON 

INSERT [dbo].[LibraryCard] ([Id], [EffectiveDate], [EffectiveEndDate], [Fee], [ReaderId], [CreatedBy], [CreatedAt]) VALUES (1, CAST(N'2022-05-10T23:17:56.000' AS DateTime), CAST(N'2022-05-19T23:17:56.793' AS DateTime), 500000.0000, N'RD00000001', N'LB00000011', CAST(N'2022-05-19T23:18:01.747' AS DateTime))
INSERT [dbo].[LibraryCard] ([Id], [EffectiveDate], [EffectiveEndDate], [Fee], [ReaderId], [CreatedBy], [CreatedAt]) VALUES (2, CAST(N'2022-05-19T23:18:04.350' AS DateTime), CAST(N'2022-05-19T23:18:04.350' AS DateTime), 500000.0000, N'RD00000002', N'LB00000011', CAST(N'2022-05-19T23:18:10.120' AS DateTime))
SET IDENTITY_INSERT [dbo].[LibraryCard] OFF
GO
INSERT [dbo].[Publisher] ([Id], [Name], [Address], [PhoneNumber], [Email]) VALUES (N'PB00000001', N'Công ty TNHH Sili', N'Sili City', N'345-123-123', N'contact@sili.com')
INSERT [dbo].[Publisher] ([Id], [Name], [Address], [PhoneNumber], [Email]) VALUES (N'PB00000002', N'Nhà xuất bản Loulai', N'Sili City', N'123-123-123', N'contact@loulai.com')
INSERT [dbo].[Publisher] ([Id], [Name], [Address], [PhoneNumber], [Email]) VALUES (N'PB00000003', N'Công ty xuất bản sách Sera', N'Sili Bay', N'435-456-243', N'contact@sera.com')
INSERT [dbo].[Publisher] ([Id], [Name], [Address], [PhoneNumber], [Email]) VALUES (N'PB00000004', N'Nhà xuất bản Igura', N'Sili Tower', N'456-432-234', N'contract@igura.com')
GO
INSERT [dbo].[Reader] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email], [PhoneNumber], [LibrarianId]) VALUES (N'RD00000001', N'Vương', N'Ngọc Anh', 0, N'TP Hồ Chí Minh', CAST(N'2002-01-01' AS Date), N'ngocanh@gmail.com', N'0341234567', N'LB00000014')
INSERT [dbo].[Reader] ([Id], [FirstName], [LastName], [Sex], [Address], [Birthday], [Email], [PhoneNumber], [LibrarianId]) VALUES (N'RD00000002', N'asdf', N'sdf', 1, N'dsfsadfsafasfasf', CAST(N'2022-05-02' AS Date), N'dsf', N'asdf', N'LB00000014')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Account]    Script Date: 5/20/2022 1:34:38 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Account] ON [dbo].[Account]
(
	[UserableId] ASC,
	[UserableType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_BookCategory]    Script Date: 5/20/2022 1:34:38 AM ******/
ALTER TABLE [dbo].[BookCategory] ADD  CONSTRAINT [IX_BookCategory] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  CONSTRAINT [DF_Account_Enable]  DEFAULT ((1)) FOR [Enable]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_BookTitle] FOREIGN KEY([BookTitleISBN])
REFERENCES [dbo].[BookTitle] ([ISBN])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_BookTitle]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Case] FOREIGN KEY([CaseId])
REFERENCES [dbo].[Caze] ([Id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Case]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Librarian] FOREIGN KEY([LibrarianId])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Librarian]
GO
ALTER TABLE [dbo].[BookTitle]  WITH CHECK ADD  CONSTRAINT [FK_BookTitle_Publisher] FOREIGN KEY([PublisherId])
REFERENCES [dbo].[Publisher] ([Id])
GO
ALTER TABLE [dbo].[BookTitle] CHECK CONSTRAINT [FK_BookTitle_Publisher]
GO
ALTER TABLE [dbo].[BookTitle_Author]  WITH CHECK ADD  CONSTRAINT [FK_BookTitle_Author_Author] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[Author] ([Id])
GO
ALTER TABLE [dbo].[BookTitle_Author] CHECK CONSTRAINT [FK_BookTitle_Author_Author]
GO
ALTER TABLE [dbo].[BookTitle_Author]  WITH CHECK ADD  CONSTRAINT [FK_BookTitle_Author_BookTitle] FOREIGN KEY([BookTitleISBN])
REFERENCES [dbo].[BookTitle] ([ISBN])
GO
ALTER TABLE [dbo].[BookTitle_Author] CHECK CONSTRAINT [FK_BookTitle_Author_BookTitle]
GO
ALTER TABLE [dbo].[BookTitle_BookCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookTitle_BookCategory_BookCategory] FOREIGN KEY([BookCategoryId])
REFERENCES [dbo].[BookCategory] ([Id])
GO
ALTER TABLE [dbo].[BookTitle_BookCategory] CHECK CONSTRAINT [FK_BookTitle_BookCategory_BookCategory]
GO
ALTER TABLE [dbo].[BookTitle_BookCategory]  WITH CHECK ADD  CONSTRAINT [FK_BookTitle_BookCategory_BookTitle] FOREIGN KEY([BookTitleISBN])
REFERENCES [dbo].[BookTitle] ([ISBN])
GO
ALTER TABLE [dbo].[BookTitle_BookCategory] CHECK CONSTRAINT [FK_BookTitle_BookCategory_BookTitle]
GO
ALTER TABLE [dbo].[Caze]  WITH CHECK ADD  CONSTRAINT [FK_Case_BookCase] FOREIGN KEY([BookCaseId])
REFERENCES [dbo].[BookCase] ([Id])
GO
ALTER TABLE [dbo].[Caze] CHECK CONSTRAINT [FK_Case_BookCase]
GO
ALTER TABLE [dbo].[LendingSlip]  WITH CHECK ADD  CONSTRAINT [FK_LendingSlip_Reader] FOREIGN KEY([ReaderId])
REFERENCES [dbo].[Reader] ([Id])
GO
ALTER TABLE [dbo].[LendingSlip] CHECK CONSTRAINT [FK_LendingSlip_Reader]
GO
ALTER TABLE [dbo].[LendingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LendingSlipDetail_Book] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
GO
ALTER TABLE [dbo].[LendingSlipDetail] CHECK CONSTRAINT [FK_LendingSlipDetail_Book]
GO
ALTER TABLE [dbo].[LendingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LendingSlipDetail_LendingSlip] FOREIGN KEY([LendingSlipId])
REFERENCES [dbo].[LendingSlip] ([Id])
GO
ALTER TABLE [dbo].[LendingSlipDetail] CHECK CONSTRAINT [FK_LendingSlipDetail_LendingSlip]
GO
ALTER TABLE [dbo].[LendingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LendingSlipDetail_Librarian] FOREIGN KEY([TookBackBy])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[LendingSlipDetail] CHECK CONSTRAINT [FK_LendingSlipDetail_Librarian]
GO
ALTER TABLE [dbo].[LendingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LendingSlipDetail_Librarian1] FOREIGN KEY([ExtendedBy])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[LendingSlipDetail] CHECK CONSTRAINT [FK_LendingSlipDetail_Librarian1]
GO
ALTER TABLE [dbo].[LibraryCard]  WITH CHECK ADD  CONSTRAINT [FK_LibraryCard_Librarian] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[LibraryCard] CHECK CONSTRAINT [FK_LibraryCard_Librarian]
GO
ALTER TABLE [dbo].[LibraryCard]  WITH CHECK ADD  CONSTRAINT [FK_LibraryCard_Reader] FOREIGN KEY([ReaderId])
REFERENCES [dbo].[Reader] ([Id])
GO
ALTER TABLE [dbo].[LibraryCard] CHECK CONSTRAINT [FK_LibraryCard_Reader]
GO
ALTER TABLE [dbo].[LiquidatingSlip]  WITH CHECK ADD  CONSTRAINT [FK_LiquidatingSlip_Librarian] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[LiquidatingSlip] CHECK CONSTRAINT [FK_LiquidatingSlip_Librarian]
GO
ALTER TABLE [dbo].[LiquidatingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LiquidatingSlipDetail_Book1] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
GO
ALTER TABLE [dbo].[LiquidatingSlipDetail] CHECK CONSTRAINT [FK_LiquidatingSlipDetail_Book1]
GO
ALTER TABLE [dbo].[LiquidatingSlipDetail]  WITH CHECK ADD  CONSTRAINT [FK_LiquidatingSlipDetail_LiquidatingSlip] FOREIGN KEY([LiquidatingSlipId])
REFERENCES [dbo].[LiquidatingSlip] ([Id])
GO
ALTER TABLE [dbo].[LiquidatingSlipDetail] CHECK CONSTRAINT [FK_LiquidatingSlipDetail_LiquidatingSlip]
GO
ALTER TABLE [dbo].[Reader]  WITH CHECK ADD  CONSTRAINT [FK_Reader_Librarian] FOREIGN KEY([LibrarianId])
REFERENCES [dbo].[Librarian] ([Id])
GO
ALTER TABLE [dbo].[Reader] CHECK CONSTRAINT [FK_Reader_Librarian]
GO
/****** Object:  StoredProcedure [dbo].[sp_create_author]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_create_author]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150)
AS
BEGIN
	INSERT INTO Author (Id, FirstName, LastName, Birthday, Sex, Address, Email)
	VAlUES (@id, @first_name, @last_name, @birthday, @sex, @address, @email)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_book]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_create_book]
	@id NCHAR(10),
	@size SMALLINT,
	@notes NVARCHAR(MAX),
	@case_id INT,
	@book_title_isbn NCHAR(13),
	@librarian_id NCHAR(10),
	@status SMALLINT
as
begin
	INSERT INTO Book (Id, Size, Notes, CaseId, BookTitleISBN, LibrarianId, CreatedAt, Status, Lending)
	VALUES (@id, @size, @notes, @case_id, @book_title_isbn, @librarian_id, CURRENT_TIMESTAMP, @status, 0)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_book_title]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_create_book_title]
	@ISBN NCHAR(13),
	@name NVARCHAR(MAX),
	@pages INT,
	@price MONEY,
	@release_date DATE,
	@publisher_id NCHAR(10),
	@categories NVARCHAR(MAX),
	@authors NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		INSERT INTO BookTitle (ISBN, Name, Pages, Price, ReleaseDate, PublisherId)
		VAlUES (@ISBN, @name, @pages, @price, @release_date, @publisher_id)

		INSERT INTO BookTitle_BookCategory
		SELECT @ISBN as BookTitleISBN, value as BookCategoryId FROM STRING_SPLIT(@categories, ',')

		INSERT INTO BookTitle_Author
		SELECT @ISBN as BookTitleISBN, value as AuthorId FROM STRING_SPLIT(@authors, ',');

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_lending_slip]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_create_lending_slip]
	@id INT,
	@reader_id NCHAR(10),
	@created_by_librarian_id NCHAR(10)
as
begin
	INSERT INTO LendingSlip (ReaderId, CreatedByLibrarianId, CreatedAt)
	VALUES (@reader_id, @created_by_librarian_id, CURRENT_TIMESTAMP)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_lending_slip_detail]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_create_lending_slip_detail]
	@book_id NCHAR(10),
	@lending_slip_id INT,
	@due_back_date DATETIME,
	@notes NVARCHAR(MAX)
as
begin
	INSERT INTO LendingSlipDetail (BookId, LendingSlipId, DueBackDate, Notes, BookStatus)
	VALUES (@book_id, @lending_slip_id, @due_back_date, @notes, 1)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_create_librarian]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150)
AS
BEGIN
	INSERT INTO Librarian (Id, FirstName, LastName, Birthday, Sex, Address, Email)
	VAlUES (@id, @first_name, @last_name, @birthday, @sex, @address, @email)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_librarian_include_account]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_create_librarian_include_account]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150),
	@username NVARCHAR(50),
	@password NVARCHAR(MAX),
	@enable bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		INSERT INTO Librarian (Id, FirstName, LastName, Birthday, Sex, Address, Email)
		VAlUES (@id, @first_name, @last_name, @birthday, @sex, @address, @email)

		INSERT INTO Account(Username, PasswordDigest, Enable, UserableId, UserableType)
		VAlUES (@username, @password, @enable, @id, N'Librarian')

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_create_library_card]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_create_library_card]
	@id BIGINT,
	@effective_date DATETIME,
	@effective_end_date DATETIME,
	@fee MONEY,
	@reader_id NCHAR(10),
	@created_by NCHAR(10)
as
begin
	INSERT INTO LibraryCard (EffectiveDate, EffectiveEndDate, Fee, ReaderId, CreatedBy, CreatedAt)
	VALUES (@effective_date, @effective_end_date, @fee, @reader_id, @created_by, CURRENT_TIMESTAMP)
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_reader]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_create_reader]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150),
	@phone_number NVARCHAR(20),
	@librarian_id NCHAR(10)
AS
BEGIN
	INSERT INTO Reader (Id, FirstName, LastName, Birthday, Sex, Address, Email, PhoneNumber, LibrarianId)
	VAlUES (@id, @first_name, @last_name, @birthday, @sex, @address, @email, @phone_number, @librarian_id)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_book_title]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_book_title]
	@isbn NCHAR(13)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		DELETE FROM BookTitle_Author WHERE BookTitleISBN = @isbn
		DELETE FROM BookTitle_BookCategory WHERE BookTitleISBN = @isbn
		DELETE FROM BookTitle WHERE ISBN = @isbn

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_delete_librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_delete_librarian]
	@id NCHAR(10)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
		DECLARE @username NVARCHAR(50)
		DELETE FROM Librarian WHERE Id = @id
		DELETE FROM Account WHERE UserableId = @id AND UserableType = N'Librarian'
	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_librarian_login]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_librarian_login]
	@username NVARCHAR(50),
	@password_digest NVARCHAR(MAX)
AS
BEGIN
	DECLARE @librarian_id NCHAR(10), @enable BIT
	SELECT @librarian_id = UserableId, @enable = Enable FROM Account WHERE Username = @username AND PasswordDigest = @password_digest AND UserableType = N'Librarian'

	IF @librarian_id IS NULL
		RAISERROR('Thông tin đăng nhập không chính xác!', 16 , 1) WITH NOWAIT
	
	IF @enable = 'False'
		RAISERROR('Tài khoản đang bị khóa hoặc chưa được kích hoạt!', 16 , 1) WITH NOWAIT

	SELECT * FROM Librarian WHERE Librarian.Id = @librarian_id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_author]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_author]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150)
AS
BEGIN
	UPDATE Author
		SET FirstName = @first_name,
			LastName = @last_name,
			Birthday = @birthday,
			Sex = @sex,
			Address = @address,
			Email = @email
	WHERE Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_book]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_book]
	@id NCHAR(10),
	@size SMALLINT,
	@notes NVARCHAR(MAX),
	@case_id INT,
	@book_title_isbn NCHAR(13),
	@librarian_id NCHAR(10),
	@status SMALLINT
AS
BEGIN
	UPDATE Book
		SET Size = @size,
			Notes = @notes,
			CaseId = @case_id,
			BookTitleISBN = @book_title_isbn,
			LibrarianId = @librarian_id,
			Status = @status
	WHERE Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_book_title]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_book_title]
	@ISBN NCHAR(13),
	@name NVARCHAR(MAX),
	@pages INT,
	@price MONEY,
	@release_date DATE,
	@publisher_id NCHAR(10),
	@categories NVARCHAR(MAX),
	@authors NVARCHAR(MAX)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		UPDATE BookTitle
			SET Name = @name,
				Pages = @pages,
				Price = @price,
				ReleaseDate = @release_date,
				PublisherId = @publisher_id
		WHERE ISBN = @ISBN

		DELETE FROM BookTitle_BookCategory WHERE BookTitleISBN = @isbn

		INSERT INTO BookTitle_BookCategory
		SELECT @ISBN as BookTitleISBN, value as BookCategoryId FROM STRING_SPLIT(@categories, ',');

		DELETE FROM BookTitle_Author WHERE BookTitleISBN = @isbn

		INSERT INTO BookTitle_Author
		SELECT @ISBN as BookTitleISBN, value as AuthorId FROM STRING_SPLIT(@authors, ',');

	COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_lending_slip]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_lending_slip]
	@id INT,
	@reader_id NCHAR(10),
	@created_by_librarian_id NCHAR(10)
AS
BEGIN
	UPDATE LendingSlip
		SET ReaderId = @reader_id,
			CreatedByLibrarianId = @created_by_librarian_id
	WHERE Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_lending_slip_detail]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_lending_slip_detail]
	@book_id NCHAR(10),
	@lending_slip_id INT,
	@due_back_date DATETIME,
	@notes NVARCHAR(MAX)
AS
BEGIN
	UPDATE LendingSlipDetail
		SET DueBackDate = @due_back_date,
			Notes = @notes
	WHERE BookId = @book_id AND LendingSlipId = @lending_slip_id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_librarian]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_librarian]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150)
AS
BEGIN
	UPDATE Librarian
		SET FirstName = @first_name,
			LastName = @last_name,
			Birthday = @birthday,
			Sex = @sex,
			Address = @address,
			Email = @email
	WHERE Id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_librarian_account]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_librarian_account]
	@librarian_id NCHAR(10),
	@username NVARCHAR(50),
	@password_digest NVARCHAR(MAX)
AS
BEGIN
	UPDATE Account
		SET Username = @username,
			PasswordDigest = @password_digest
	WHERE UserableId = @librarian_id AND UserableType = N'Librarian'
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_librarian_include_account]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_update_librarian_include_account]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150),
	@username NVARCHAR(50),
	@password NVARCHAR(MAX),
	@enable bit
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		UPDATE Librarian
		SET FirstName = @first_name,
			LastName = @last_name,
			Birthday = @birthday,
			Sex = @sex,
			Address = @address,
			Email = @email
		WHERE Id = @id

		UPDATE Account
		SET Username = @username,
			PasswordDigest = @password,
			Enable = @enable
		WHERE UserableId = @id AND UserableType = N'Librarian'

		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
        ROLLBACK TRANSACTION
		
		DECLARE @ErrorMessage VARCHAR(MAX), @ErrorSeverity INT, @ErrorState INT
		SET @ErrorMessage  = ERROR_MESSAGE()
		SET @ErrorSeverity = ERROR_SEVERITY()
		SET @ErrorState    = ERROR_STATE()

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState)
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_update_library_card]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_update_library_card]
	@id BIGINT,
	@effective_date DATETIME,
	@effective_end_date DATETIME,
	@fee MONEY,
	@reader_id NCHAR(10),
	@created_by NCHAR(10)
as
begin
	UPDATE LibraryCard
		SET EffectiveDate = @effective_date,
			EffectiveEndDate = @effective_end_date
	WHERE Id = @id
end
GO
/****** Object:  StoredProcedure [dbo].[sp_update_reader]    Script Date: 5/20/2022 1:34:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_update_reader]
	@id NCHAR(10),
	@first_name NVARCHAR(30),
	@last_name NVARCHAR(50),
	@birthday DATE,
	@sex BIT,
	@address NVARCHAR(150),
	@email NVARCHAR(150),
	@phone_number NVARCHAR(20),
	@librarian_id NCHAR(10)
AS
BEGIN
	UPDATE Reader
		SET FirstName = @first_name,
			LastName = @last_name,
			Birthday = @birthday,
			Sex = @sex,
			Address = @address,
			Email = @email,
			PhoneNumber = @phone_number,
			LibrarianId = @librarian_id
	WHERE Id = @id
END
GO
USE [master]
GO
ALTER DATABASE [QLTV] SET  READ_WRITE 
GO
