using SalyasAcademy.Domain.Common;

namespace SalyasAcademy.Domain.Entities;

public class Announcement : AuditableEntity
{
    public Guid AcademyId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    
    public string TargetAudience { get; set; } = "All"; // All, Parents, Students, Teachers, SpecificBatch
    public Guid? TargetBatchId { get; set; }
}
