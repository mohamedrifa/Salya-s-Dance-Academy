using System.ComponentModel.DataAnnotations;

namespace SalyasAcademy.Application.DTOs;

public class UpdateProfileRequest
{
    [Required]
    public string FirstName { get; set; } = string.Empty;

    [Required]
    public string LastName { get; set; } = string.Empty;
}
