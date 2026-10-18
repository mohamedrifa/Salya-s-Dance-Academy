IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [AspNetRoles] (
    [Id] uniqueidentifier NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetUsers] (
    [Id] uniqueidentifier NOT NULL,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [IsActive] bit NOT NULL,
    [AcademyId] uniqueidentifier NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] uniqueidentifier NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] uniqueidentifier NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserRoles] (
    [UserId] uniqueidentifier NOT NULL,
    [RoleId] uniqueidentifier NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserTokens] (
    [UserId] uniqueidentifier NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260906155409_InitialCreate', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [Batches] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyId] uniqueidentifier NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [Level] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NULL,
    [DefaultFeePlanId] uniqueidentifier NULL,
    [Status] nvarchar(max) NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Batches] PRIMARY KEY ([Id])
);

CREATE TABLE [Parents] (
    [Id] uniqueidentifier NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [MobileNumber] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NULL,
    [Address] nvarchar(max) NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Parents] PRIMARY KEY ([Id])
);

CREATE TABLE [Students] (
    [Id] uniqueidentifier NOT NULL,
    [UserId] uniqueidentifier NOT NULL,
    [FirstName] nvarchar(100) NOT NULL,
    [LastName] nvarchar(100) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    [Gender] nvarchar(max) NOT NULL,
    [BloodGroup] nvarchar(max) NULL,
    [Address] nvarchar(max) NULL,
    [EmergencyContactNumber] nvarchar(max) NULL,
    [JoiningDate] datetime2 NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY ([Id])
);

CREATE TABLE [ClassSchedules] (
    [Id] uniqueidentifier NOT NULL,
    [BatchId] uniqueidentifier NOT NULL,
    [DayOfWeek] int NOT NULL,
    [StartTime] time NOT NULL,
    [EndTime] time NOT NULL,
    CONSTRAINT [PK_ClassSchedules] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClassSchedules_Batches_BatchId] FOREIGN KEY ([BatchId]) REFERENCES [Batches] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [BatchStudents] (
    [Id] uniqueidentifier NOT NULL,
    [BatchId] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [JoinedAt] datetime2 NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_BatchStudents] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_BatchStudents_Batches_BatchId] FOREIGN KEY ([BatchId]) REFERENCES [Batches] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_BatchStudents_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE NO ACTION
);

CREATE TABLE [StudentParents] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [ParentId] uniqueidentifier NOT NULL,
    [Relationship] nvarchar(max) NOT NULL,
    [IsPrimaryContact] bit NOT NULL,
    CONSTRAINT [PK_StudentParents] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_StudentParents_Parents_ParentId] FOREIGN KEY ([ParentId]) REFERENCES [Parents] ([Id]) ON DELETE NO ACTION,
    CONSTRAINT [FK_StudentParents_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE NO ACTION
);

CREATE INDEX [IX_BatchStudents_BatchId] ON [BatchStudents] ([BatchId]);

CREATE INDEX [IX_BatchStudents_StudentId] ON [BatchStudents] ([StudentId]);

CREATE INDEX [IX_ClassSchedules_BatchId] ON [ClassSchedules] ([BatchId]);

CREATE INDEX [IX_StudentParents_ParentId] ON [StudentParents] ([ParentId]);

CREATE INDEX [IX_StudentParents_StudentId] ON [StudentParents] ([StudentId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260906155747_Phase1Entities', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [ClassSessions] (
    [Id] uniqueidentifier NOT NULL,
    [BatchId] uniqueidentifier NOT NULL,
    [SessionDate] datetime2 NOT NULL,
    [StartTime] time NOT NULL,
    [EndTime] time NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [TopicsCovered] nvarchar(max) NULL,
    [TeacherId] uniqueidentifier NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_ClassSessions] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_ClassSessions_Batches_BatchId] FOREIGN KEY ([BatchId]) REFERENCES [Batches] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [FeePlans] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyId] uniqueidentifier NOT NULL,
    [Name] nvarchar(max) NOT NULL,
    [MonthlyAmount] decimal(18,2) NOT NULL,
    [AdmissionFee] decimal(18,2) NOT NULL,
    [Description] nvarchar(max) NULL,
    [IsActive] bit NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_FeePlans] PRIMARY KEY ([Id])
);

CREATE TABLE [MonthlyFeeObligations] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [Year] int NOT NULL,
    [Month] int NOT NULL,
    [AmountDue] decimal(18,2) NOT NULL,
    [AmountPaid] decimal(18,2) NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [DueDate] datetime2 NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_MonthlyFeeObligations] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_MonthlyFeeObligations_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AttendanceRecords] (
    [Id] uniqueidentifier NOT NULL,
    [ClassSessionId] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    [Remarks] nvarchar(max) NULL,
    CONSTRAINT [PK_AttendanceRecords] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AttendanceRecords_ClassSessions_ClassSessionId] FOREIGN KEY ([ClassSessionId]) REFERENCES [ClassSessions] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AttendanceRecords_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Payments] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [MonthlyFeeObligationId] uniqueidentifier NULL,
    [Amount] decimal(18,2) NOT NULL,
    [PaymentDate] datetime2 NOT NULL,
    [PaymentMethod] nvarchar(max) NOT NULL,
    [TransactionReference] nvarchar(max) NULL,
    [ProofImageUrl] nvarchar(max) NULL,
    [Status] nvarchar(max) NOT NULL,
    [ReviewedBy] uniqueidentifier NULL,
    [ReviewRemarks] nvarchar(max) NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Payments] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Payments_MonthlyFeeObligations_MonthlyFeeObligationId] FOREIGN KEY ([MonthlyFeeObligationId]) REFERENCES [MonthlyFeeObligations] ([Id]),
    CONSTRAINT [FK_Payments_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_AttendanceRecords_ClassSessionId] ON [AttendanceRecords] ([ClassSessionId]);

CREATE INDEX [IX_AttendanceRecords_StudentId] ON [AttendanceRecords] ([StudentId]);

CREATE INDEX [IX_ClassSessions_BatchId] ON [ClassSessions] ([BatchId]);

CREATE INDEX [IX_MonthlyFeeObligations_StudentId] ON [MonthlyFeeObligations] ([StudentId]);

CREATE INDEX [IX_Payments_MonthlyFeeObligationId] ON [Payments] ([MonthlyFeeObligationId]);

CREATE INDEX [IX_Payments_StudentId] ON [Payments] ([StudentId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260906161006_Phase2Entities', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [Announcements] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Content] nvarchar(max) NOT NULL,
    [TargetAudience] nvarchar(max) NOT NULL,
    [TargetBatchId] uniqueidentifier NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Announcements] PRIMARY KEY ([Id])
);

CREATE TABLE [Lessons] (
    [Id] uniqueidentifier NOT NULL,
    [BatchId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NULL,
    [VideoUrl] nvarchar(max) NULL,
    [OrderSequence] int NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Lessons] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Lessons_Batches_BatchId] FOREIGN KEY ([BatchId]) REFERENCES [Batches] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [LearningResources] (
    [Id] uniqueidentifier NOT NULL,
    [LessonId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Type] nvarchar(max) NOT NULL,
    [Url] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_LearningResources] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_LearningResources_Lessons_LessonId] FOREIGN KEY ([LessonId]) REFERENCES [Lessons] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [PracticeSubmissions] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [LessonId] uniqueidentifier NOT NULL,
    [VideoUrl] nvarchar(max) NOT NULL,
    [StudentNotes] nvarchar(max) NULL,
    [Status] nvarchar(max) NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_PracticeSubmissions] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_PracticeSubmissions_Lessons_LessonId] FOREIGN KEY ([LessonId]) REFERENCES [Lessons] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_PracticeSubmissions_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [TeacherFeedbacks] (
    [Id] uniqueidentifier NOT NULL,
    [PracticeSubmissionId] uniqueidentifier NOT NULL,
    [TeacherId] uniqueidentifier NOT NULL,
    [Remarks] nvarchar(max) NOT NULL,
    [Rating] int NOT NULL,
    [ReviewedAt] datetime2 NOT NULL,
    CONSTRAINT [PK_TeacherFeedbacks] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_TeacherFeedbacks_PracticeSubmissions_PracticeSubmissionId] FOREIGN KEY ([PracticeSubmissionId]) REFERENCES [PracticeSubmissions] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_LearningResources_LessonId] ON [LearningResources] ([LessonId]);

CREATE INDEX [IX_Lessons_BatchId] ON [Lessons] ([BatchId]);

CREATE INDEX [IX_PracticeSubmissions_LessonId] ON [PracticeSubmissions] ([LessonId]);

CREATE INDEX [IX_PracticeSubmissions_StudentId] ON [PracticeSubmissions] ([StudentId]);

CREATE UNIQUE INDEX [IX_TeacherFeedbacks_PracticeSubmissionId] ON [TeacherFeedbacks] ([PracticeSubmissionId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260906161924_Phase3Entities', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
DROP TABLE [Announcements];

CREATE TABLE [AcademyEvents] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [EventDate] datetime2 NOT NULL,
    [Location] nvarchar(max) NOT NULL,
    [ParticipationFee] decimal(18,2) NULL,
    [Status] nvarchar(max) NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_AcademyEvents] PRIMARY KEY ([Id])
);

CREATE TABLE [Certificates] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Description] nvarchar(max) NOT NULL,
    [IssueDate] datetime2 NOT NULL,
    [CertificateImageUrl] nvarchar(max) NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Certificates] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Certificates_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [Messages] (
    [Id] uniqueidentifier NOT NULL,
    [SenderId] uniqueidentifier NOT NULL,
    [ReceiverId] uniqueidentifier NOT NULL,
    [Subject] nvarchar(max) NOT NULL,
    [Content] nvarchar(max) NOT NULL,
    [IsRead] bit NOT NULL,
    [ReadAt] datetime2 NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Messages] PRIMARY KEY ([Id])
);

CREATE TABLE [SkillAssessments] (
    [Id] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [TeacherId] uniqueidentifier NOT NULL,
    [BatchId] uniqueidentifier NOT NULL,
    [AssessmentDate] datetime2 NOT NULL,
    [SkillLevel] nvarchar(max) NOT NULL,
    [Remarks] nvarchar(max) NOT NULL,
    [Score] int NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_SkillAssessments] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_SkillAssessments_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [EventParticipants] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyEventId] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [HasPaidFee] bit NOT NULL,
    [Status] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_EventParticipants] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_EventParticipants_AcademyEvents_AcademyEventId] FOREIGN KEY ([AcademyEventId]) REFERENCES [AcademyEvents] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_EventParticipants_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_Certificates_StudentId] ON [Certificates] ([StudentId]);

CREATE INDEX [IX_EventParticipants_AcademyEventId] ON [EventParticipants] ([AcademyEventId]);

CREATE INDEX [IX_EventParticipants_StudentId] ON [EventParticipants] ([StudentId]);

CREATE INDEX [IX_SkillAssessments_StudentId] ON [SkillAssessments] ([StudentId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260906162052_Phase456Entities', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [SkillAssessments] ADD [SkillName] nvarchar(max) NOT NULL DEFAULT N'';

ALTER TABLE [SkillAssessments] ADD [SkillType] nvarchar(max) NOT NULL DEFAULT N'';

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260907170751_AddSkillTypeAndName', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [EventParticipants] ADD [CreatedAt] datetimeoffset NOT NULL DEFAULT '0001-01-01T00:00:00.0000000+00:00';

ALTER TABLE [EventParticipants] ADD [CreatedBy] uniqueidentifier NULL;

ALTER TABLE [EventParticipants] ADD [DeletedAt] datetimeoffset NULL;

ALTER TABLE [EventParticipants] ADD [DeletedBy] uniqueidentifier NULL;

ALTER TABLE [EventParticipants] ADD [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [EventParticipants] ADD [UpdatedAt] datetimeoffset NULL;

ALTER TABLE [EventParticipants] ADD [UpdatedBy] uniqueidentifier NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260907180407_UpdateEventParticipantAuditable', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [Students] ADD [FeePlanId] uniqueidentifier NULL;

CREATE INDEX [IX_Students_FeePlanId] ON [Students] ([FeePlanId]);

ALTER TABLE [Students] ADD CONSTRAINT [FK_Students_FeePlans_FeePlanId] FOREIGN KEY ([FeePlanId]) REFERENCES [FeePlans] ([Id]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260920162758_AddFeePlanToStudent', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [Lessons] DROP CONSTRAINT [FK_Lessons_Batches_BatchId];

DECLARE @var nvarchar(max);
SELECT @var = QUOTENAME([d].[name])
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Lessons]') AND [c].[name] = N'BatchId');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [Lessons] DROP CONSTRAINT ' + @var + ';');
ALTER TABLE [Lessons] ALTER COLUMN [BatchId] uniqueidentifier NULL;

ALTER TABLE [Lessons] ADD CONSTRAINT [FK_Lessons_Batches_BatchId] FOREIGN KEY ([BatchId]) REFERENCES [Batches] ([Id]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260920171342_MakeLessonBatchNullable', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [LessonProgresses] (
    [Id] uniqueidentifier NOT NULL,
    [LessonId] uniqueidentifier NOT NULL,
    [StudentId] uniqueidentifier NOT NULL,
    [IsFullyWatched] bit NOT NULL,
    [WatchDurationSeconds] int NOT NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    CONSTRAINT [PK_LessonProgresses] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_LessonProgresses_Lessons_LessonId] FOREIGN KEY ([LessonId]) REFERENCES [Lessons] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_LessonProgresses_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_LessonProgresses_LessonId] ON [LessonProgresses] ([LessonId]);

CREATE INDEX [IX_LessonProgresses_StudentId] ON [LessonProgresses] ([StudentId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260925064320_AddLessonProgress', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
CREATE TABLE [Announcements] (
    [Id] uniqueidentifier NOT NULL,
    [AcademyId] uniqueidentifier NOT NULL,
    [Title] nvarchar(max) NOT NULL,
    [Content] nvarchar(max) NOT NULL,
    [TargetAudience] nvarchar(max) NOT NULL,
    [TargetBatchId] uniqueidentifier NULL,
    [CreatedAt] datetimeoffset NOT NULL,
    [CreatedBy] uniqueidentifier NULL,
    [UpdatedAt] datetimeoffset NULL,
    [UpdatedBy] uniqueidentifier NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedAt] datetimeoffset NULL,
    [DeletedBy] uniqueidentifier NULL,
    CONSTRAINT [PK_Announcements] PRIMARY KEY ([Id])
);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260925070640_AddAnnouncements', N'10.0.11');

COMMIT;
GO

BEGIN TRANSACTION;
ALTER TABLE [AspNetUsers] ADD [ProfilePictureUrl] nvarchar(max) NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260925094102_AddProfilePicture', N'10.0.11');

COMMIT;
GO

