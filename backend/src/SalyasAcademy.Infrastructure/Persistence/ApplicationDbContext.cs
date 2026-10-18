using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using SalyasAcademy.Infrastructure.Identity;

namespace SalyasAcademy.Infrastructure.Persistence;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser, IdentityRole<Guid>, Guid>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    public DbSet<SalyasAcademy.Domain.Entities.Student> Students { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Parent> Parents { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.StudentParent> StudentParents { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Batch> Batches { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.BatchStudent> BatchStudents { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.ClassSchedule> ClassSchedules { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.FeePlan> FeePlans { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.MonthlyFeeObligation> MonthlyFeeObligations { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Payment> Payments { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.ClassSession> ClassSessions { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.AttendanceRecord> AttendanceRecords { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Lesson> Lessons { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.LessonProgress> LessonProgresses { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.LearningResource> LearningResources { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.PracticeSubmission> PracticeSubmissions { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.TeacherFeedback> TeacherFeedbacks { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.SkillAssessment> SkillAssessments { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Certificate> Certificates { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Message> Messages { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.AcademyEvent> AcademyEvents { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.EventParticipant> EventParticipants { get; set; }
    public DbSet<SalyasAcademy.Domain.Entities.Announcement> Announcements { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);
        builder.ApplyConfigurationsFromAssembly(typeof(ApplicationDbContext).Assembly);
        
        builder.Entity<SalyasAcademy.Domain.Entities.AcademyEvent>().Property(p => p.ParticipationFee).HasColumnType("decimal(18,2)");
        builder.Entity<SalyasAcademy.Domain.Entities.FeePlan>().Property(p => p.AdmissionFee).HasColumnType("decimal(18,2)");
        builder.Entity<SalyasAcademy.Domain.Entities.FeePlan>().Property(p => p.MonthlyAmount).HasColumnType("decimal(18,2)");
        builder.Entity<SalyasAcademy.Domain.Entities.MonthlyFeeObligation>().Property(p => p.AmountDue).HasColumnType("decimal(18,2)");
        builder.Entity<SalyasAcademy.Domain.Entities.MonthlyFeeObligation>().Property(p => p.AmountPaid).HasColumnType("decimal(18,2)");
        builder.Entity<SalyasAcademy.Domain.Entities.Payment>().Property(p => p.Amount).HasColumnType("decimal(18,2)");
    }
}
