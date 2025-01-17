USE [GravityBooksDWH]
GO
/****** Object:  Table [dbo].[DimAddress]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimAddress](
	[Address_id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Address_id_BK] [int] NOT NULL,
	[street_number] [varchar](50) NULL,
	[street_name] [varchar](200) NULL,
	[city] [varchar](100) NULL,
	[country_name] [varchar](200) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
 CONSTRAINT [PK_DimAddress] PRIMARY KEY CLUSTERED 
)
GO

/****** Object:  Table [dbo].[DimAuthor]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimAuthor](
	[Author_id_SK] [int] NOT NULL,
	[author_name] [varchar](400) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
 CONSTRAINT [PK_DimAuthor] PRIMARY KEY CLUSTERED 
)
GO

/****** Object:  Table [dbo].[DimAuthorBook]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimAuthorBook](
	[Book_id_FK] [int] NOT NULL,
	[Author_id_FK] [int] NOT NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
 CONSTRAINT [PK_DimAuthorBook] PRIMARY KEY CLUSTERED 
)
GO

/****** Object:  Table [dbo].[DimBook]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimBook](
	[BookID_SK] [int] IDENTITY(1,1) NOT NULL,
	[BookID_BK] [int] NOT NULL,
	[title] [varchar](400) NULL,
	[publisherID_BK] [int] NOT NULL,
	[publisher_name] [varchar](400) NULL,
	[publication_date] [date] NULL,
	[num_pages] [int] NULL,
	[language_code_BK] [varchar](8) NOT NULL,
	[language_name] [varchar](50) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
 CONSTRAINT [PK_DimBook] PRIMARY KEY CLUSTERED 
)
GO

/****** Object:  Table [dbo].[DimCustomer]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimCustomer](
	[Customer_id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Customer_id_PK] [int] NOT NULL,
	[Name] [varchar](450) NULL,
	[email] [varchar](200) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
 CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED 
)

/****** Object:  Table [dbo].[DimDate]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimDate](
	[DateSK] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[Day] [char](2) NOT NULL,
	[DaySuffix] [varchar](4) NOT NULL,
	[DayOfWeek] [varchar](9) NOT NULL,
	[DOWInMonth] [tinyint] NOT NULL,
	[DayOfYear] [int] NOT NULL,
	[WeekOfYear] [tinyint] NOT NULL,
	[WeekOfMonth] [tinyint] NOT NULL,
	[Month] [char](2) NOT NULL,
	[MonthName] [varchar](9) NOT NULL,
	[Quarter] [tinyint] NOT NULL,
	[QuarterName] [varchar](6) NOT NULL,
	[Year] [char](4) NOT NULL,
	[StandardDate] [varchar](10) NULL,
	[HolidayText] [varchar](50) NULL,
 CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED 
)
GO

/****** Object:  Table [dbo].[DimShipping]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[DimShipping](
	[Ship_Method_id_SK] [int] IDENTITY(1,1) NOT NULL,
	[Ship_Method_id_BK] [int] NOT NULL,
	[method_name] [varchar](100) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[is_current] [bit] NULL,
	[SourceSystemCode] [tinyint] NULL,
	[cost] [decimal](6, 2) NULL,
)
GO

/****** Object:  Table [dbo].[FactOrderLifecycle]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[FactOrderLifecycle](
	[Fact_Sales_PK_SK] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID_FK] [int] NOT NULL,
	[ShippingID_FK] [int] NOT NULL,
	[BookID_FK] [int] NOT NULL,
	[OrderID_BK] [int] NOT NULL,
	[OrderDetailsID_BK] [int] NOT NULL,
	[AddressID_FK] [int] NOT NULL,
	[Address_status] [varchar](30) NULL,
	[order_status_received_fk] [int] NULL,
	[Order_status_PendingDelivery_fk] [int] NULL,
	[Order_status_inProgress_fk] [int] NULL,
	[Order_status_Delivered_fk] [int] NULL,
	[Order_status_Cancelled_fk] [int] NULL,
	[Order_status_Returned_fk] [int] NULL,
	[Price] [decimal](5, 2) NULL,
	[Created_at] [datetime] NOT NULL,
	[SourceSystemCode] [tinyint] NULL,
	[history_id] [int] NOT NULL,
 CONSTRAINT [PK_FactOrder] PRIMARY KEY CLUSTERED 
)
GO
/****** Object:  Table [dbo].[Meta_Control_Fact_Sales_Load]    Script Date: 2/17/2024 7:08:17 PM ******/

CREATE TABLE [dbo].[Meta_Control_Fact_Sales_Load](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[history] [varchar](50) NULL,
	[Last_history_id] [int] NOT NULL,
	[Load_date] [datetime] NOT NULL
) 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] ADD  CONSTRAINT [DF_FactOrderLifecycle_Created_at]  DEFAULT (getdate()) FOR [Created_at]
GO

ALTER TABLE [dbo].[Meta_Control_Fact_Sales_Load] ADD  CONSTRAINT [DF_Meta_Control_Fact_Sales_Load_Load_date]  DEFAULT (getdate()) FOR [Load_date]
GO

ALTER TABLE [dbo].[DimAuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_DimAuthorBook_DimAuthor] FOREIGN KEY([Author_id_FK])
REFERENCES [dbo].[DimAuthor] ([Author_id_SK])
GO

ALTER TABLE [dbo].[DimAuthorBook] CHECK CONSTRAINT [FK_DimAuthorBook_DimAuthor]
GO

ALTER TABLE [dbo].[DimAuthorBook]  WITH CHECK ADD  CONSTRAINT [FK_DimAuthorBook_DimBook] FOREIGN KEY([Book_id_FK])
REFERENCES [dbo].[DimBook] ([BookID_BK])
GO

ALTER TABLE [dbo].[DimAuthorBook] CHECK CONSTRAINT [FK_DimAuthorBook_DimBook]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH CHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimAddress] FOREIGN KEY([AddressID_FK])
REFERENCES [dbo].[DimAddress] ([Address_id_SK])
GO

ALTER TABLE [dbo].[FactOrderLifecycle] CHECK CONSTRAINT [FK_FactOrderLifecycle_DimAddress]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH CHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimBook] FOREIGN KEY([BookID_FK])
REFERENCES [dbo].[DimBook] ([BookID_SK])
GO

ALTER TABLE [dbo].[FactOrderLifecycle] CHECK CONSTRAINT [FK_FactOrderLifecycle_DimBook]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH CHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimCustomer] FOREIGN KEY([CustomerID_FK])
REFERENCES [dbo].[DimCustomer] ([Customer_id_SK])
GO

ALTER TABLE [dbo].[FactOrderLifecycle] CHECK CONSTRAINT [FK_FactOrderLifecycle_DimCustomer]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate] FOREIGN KEY([order_status_received_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate1] FOREIGN KEY([Order_status_PendingDelivery_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate1]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate2] FOREIGN KEY([Order_status_inProgress_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate2]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate3] FOREIGN KEY([Order_status_Delivered_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate3]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate4] FOREIGN KEY([Order_status_Cancelled_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate4]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimDate5] FOREIGN KEY([Order_status_Returned_fk])
REFERENCES [dbo].[DimDate] ([DateSK])
NOT FOR REPLICATION 
GO

ALTER TABLE [dbo].[FactOrderLifecycle] NOCHECK CONSTRAINT [FK_FactOrderLifecycle_DimDate5]
GO

ALTER TABLE [dbo].[FactOrderLifecycle]  WITH CHECK ADD  CONSTRAINT [FK_FactOrderLifecycle_DimShipping] FOREIGN KEY([ShippingID_FK])
REFERENCES [dbo].[DimShipping] ([Ship_Method_id_SK])
GO

ALTER TABLE [dbo].[FactOrderLifecycle] CHECK CONSTRAINT [FK_FactOrderLifecycle_DimShipping]
GO
