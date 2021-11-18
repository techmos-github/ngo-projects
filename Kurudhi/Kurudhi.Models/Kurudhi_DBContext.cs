using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

#nullable disable

namespace Kurudhi.Models
{
    public partial class Kurudhi_DBContext : DbContext
    {
        public Kurudhi_DBContext()
        {
        }

        public Kurudhi_DBContext(DbContextOptions<Kurudhi_DBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<BloodGroup> BloodGroups { get; set; }
        public virtual DbSet<BloodRequest> BloodRequests { get; set; }
        public virtual DbSet<PatientInfo> PatientInfos { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<UserRole> UserRoles { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql("server=67.227.166.124;uid=Kurudhi_DBAdmin;pwd=Qjfp&531NOhkxqss;database=Kurudhi_DB", Microsoft.EntityFrameworkCore.ServerVersion.Parse("5.6.48-mysql"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasCharSet("utf8")
                .UseCollation("utf8_general_ci");

            modelBuilder.Entity<BloodGroup>(entity =>
            {
                entity.ToTable("blood_group");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(30)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<BloodRequest>(entity =>
            {
                entity.ToTable("blood_request");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .HasColumnName("id");

                entity.Property(e => e.ApprovedBy)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("approved_by");

                entity.Property(e => e.ApprovedById)
                    .HasColumnType("int(11)")
                    .HasColumnName("approved_by_id");

                entity.Property(e => e.ApprovedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("approved_date");

                entity.Property(e => e.BloodGroupId)
                    .HasColumnType("int(11)")
                    .HasColumnName("blood_group_id");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("created_by");

                entity.Property(e => e.CreatedById)
                    .HasColumnType("int(11)")
                    .HasColumnName("created_by_id");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("created_date");

                entity.Property(e => e.DueDate)
                    .HasColumnType("datetime")
                    .HasColumnName("due_date");

                entity.Property(e => e.NoUnits)
                    .HasColumnType("int(11)")
                    .HasColumnName("no_units");

                entity.Property(e => e.PatientId)
                    .HasColumnType("int(11)")
                    .HasColumnName("patient_id");

                entity.Property(e => e.RequestStatus)
                    .IsRequired()
                    .HasMaxLength(30)
                    .HasColumnName("request_status");

                entity.Property(e => e.RequestType)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("request_type");

                entity.Property(e => e.RequestedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("requested_date");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("updated_by");

                entity.Property(e => e.UpdatedById)
                    .HasColumnType("int(11)")
                    .HasColumnName("updated_by_id");

                entity.Property(e => e.UpdatedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("updated_date");
            });

            modelBuilder.Entity<PatientInfo>(entity =>
            {
                entity.ToTable("patient_info");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .HasColumnName("id");

                entity.Property(e => e.Age)
                    .HasColumnType("int(11)")
                    .HasColumnName("age");

                entity.Property(e => e.AttenderContactno)
                    .HasColumnType("int(11)")
                    .HasColumnName("attender_contactno");

                entity.Property(e => e.AttenderName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("attender_name");

                entity.Property(e => e.District)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("district");

                entity.Property(e => e.HospitalAddress)
                    .IsRequired()
                    .HasMaxLength(200)
                    .HasColumnName("hospital_address");

                entity.Property(e => e.HospitalName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("hospital_name");

                entity.Property(e => e.Location)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("location");

                entity.Property(e => e.PatientId)
                    .HasMaxLength(20)
                    .HasColumnName("patient_id");

                entity.Property(e => e.PatientName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("patient_name");

                entity.Property(e => e.PatientStatus)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("patient_status");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("roles");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .ValueGeneratedNever()
                    .HasColumnName("id");

                entity.Property(e => e.Name)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("name");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("user");

                entity.Property(e => e.Id)
                    .HasColumnType("int(11)")
                    .HasColumnName("id");

                entity.Property(e => e.ActiveStatus)
                    .HasColumnType("int(11)")
                    .HasColumnName("active_status");

                entity.Property(e => e.Age)
                    .HasColumnType("int(11)")
                    .HasColumnName("age");

                entity.Property(e => e.BloodGroupId)
                    .HasColumnType("int(11)")
                    .HasColumnName("blood_group_id");

                entity.Property(e => e.Contactno)
                    .HasColumnType("int(11)")
                    .HasColumnName("contactno");

                entity.Property(e => e.CreatedBy)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("created_by");

                entity.Property(e => e.CreatedById)
                    .HasColumnType("int(11)")
                    .HasColumnName("created_by_id");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("created_date");

                entity.Property(e => e.DeletedStatus)
                    .HasColumnType("int(11)")
                    .HasColumnName("deleted_status");

                entity.Property(e => e.District)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("district");

                entity.Property(e => e.Emailid)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("emailid");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("first_name");

                entity.Property(e => e.Gender)
                    .IsRequired()
                    .HasMaxLength(10)
                    .HasColumnName("gender");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("last_name");

                entity.Property(e => e.Location)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("location");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("password");

                entity.Property(e => e.UpdatedBy)
                    .IsRequired()
                    .HasMaxLength(100)
                    .HasColumnName("updated_by");

                entity.Property(e => e.UpdatedById)
                    .HasColumnType("int(11)")
                    .HasColumnName("updated_by_id");

                entity.Property(e => e.UpdatedDate)
                    .HasColumnType("datetime")
                    .HasColumnName("updated_date");

                entity.Property(e => e.UserProfilePhoto)
                    .HasColumnType("blob")
                    .HasColumnName("user_profile_photo");
            });

            modelBuilder.Entity<UserRole>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("user_roles");

                entity.Property(e => e.RoleId)
                    .HasColumnType("int(11)")
                    .HasColumnName("role_id");

                entity.Property(e => e.UserId)
                    .HasColumnType("int(11)")
                    .HasColumnName("user_id");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
