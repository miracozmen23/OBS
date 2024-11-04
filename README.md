# BMÜ329 Veri Tabanı Sistemleri Dersi Dönem Projesi Gereksinimleri ve E-R Diyagramı

## Proje Başlığı: Gelişmiş ve Yenilikçi Öğrenci Bilgi Sistemi (OBS)

**Proje Ekibindeki Kişiler:**
- **220260028** - Yunus Emre Gümüş
- **220260018** - Alperen Aktaş
- **220260006** - Mehmet Miraç Özmen

---

## Gelişmiş Öğrenci Bilgi Sistemi Veri Tabanı Gereksinimleri

### 1. Proje Kullanıcıları Gereksinimleri ve Yetkileri

Gelişmiş Öğrenci Bilgi Sistemi’nde üç ana kullanıcı türü bulunur: Öğrenciler, Öğretmenler ve Yöneticiler. Her kullanıcı türü, veritabanındaki verilere farklı düzeylerde erişim ve müdahale yetkisine sahiptir.

#### 1.1 Öğrenciler:
- Sadece kendi bilgilerini görüntüleyebilir.
- Devamsızlık kayıtlarını ve sınav sonuçlarını görebilir.
- Ders programına ve sınav takvimine erişebilir.
- Yalnızca okuma yetkisine sahiptir, veri girişi yapamaz.

#### 1.2 Öğretmenler:
- Kendi verdikleri derslerin öğrenci listelerine, devamsızlık kayıtlarına ve sınav sonuçlarına erişebilirler.
- Dersleri için sınav oluşturabilir ve sınav sonuçlarını güncelleyebilirler.
- Öğrencilerin ders içindeki performans durumunu görebilirler.
- Hem okuma hem yazma yetkisine sahiptir.

#### 1.3 Yöneticiler:
- Tüm öğrenci ve öğretmen kayıtlarını yönetme yetkisine sahiptir.
- Yeni dersler oluşturabilir, ders programlarını ve sınavları düzenleyebilir.
- Öğrencilerin ve öğretmenlerin bilgilerini güncelleyebilir veya sistemden çıkarabilirler.
- Veritabanındaki tüm verilere tam erişim (okuma, yazma, güncelleme ve silme) yetkisine sahiptir.

---

### 2. Tablolar ve Varlıkların Özellikleri

Her tablo, veritabanındaki bir varlık grubunu temsil eder. Bu varlıkların özellikleri (nitelikler), varlıklar arasındaki ilişkiler ve her ilişkideki sayısal kısıtlamalar aşağıda açıklanmıştır:

#### 2.1 Students (Öğrenciler)
- `id`: Birincil anahtar (PK), benzersiz öğrenci kimliği.
- `name`: Öğrenci adı, zorunlu bir metin alanı.
- `surname`: Öğrenci soyadı, zorunlu bir metin alanı.
- `student_number`: Benzersiz öğrenci numarası, her öğrenci için tekil ve zorunlu.
- `department_id`: Öğrencinin bağlı olduğu bölüm (FK, Departments tablosuna bağlı).

**İlişkiler:** 
- Bir öğrenci yalnızca bir bölüme (Departments tablosundaki bir satıra) aittir.
- Bir öğrenci birden fazla derse katılabilir ve her derste ayrı devamsızlık kaydı bulunabilir.

#### 2.2 Teachers (Öğretmenler)
- `id`: Birincil anahtar (PK), benzersiz öğretmen kimliği.
- `name`: Öğretmen adı, zorunlu bir metin alanı.
- `surname`: Öğretmen soyadı, zorunlu bir metin alanı.
- `department_id`: Öğretmenin bağlı olduğu bölüm (FK, Departments tablosuna bağlı).
- `adviser_id`: Öğrencinin bağlı olduğu danışman.

**İlişkiler:**
- Her öğretmen birden fazla derse girebilir ve birden fazla öğrenciye ders verebilir.
- Her öğretmen yalnızca bir bölüme bağlı olabilir.

#### 2.3 Courses (Dersler)
- `id`: Birincil anahtar (PK), benzersiz ders kimliği.
- `course_name`: Dersin adı, örneğin "Matematik", "Fizik" gibi.
- `teacher_id`: Dersi veren öğretmen (FK, Teachers tablosuna bağlı).
- `department_id`: Dersi veren bölüm (FK, Departments tablosuna bağlı).

**İlişkiler:**
- Her ders bir öğretmen tarafından verilir, ancak birden fazla öğrenci katılabilir.
- Her ders, yalnızca bir bölüme atanır.

#### 2.4 AttendanceRecords (Devamsızlık Kayıtları)
- `id`: Birincil anahtar (PK), benzersiz devamsızlık kaydı kimliği.
- `student_id`: Devamsızlık yapan öğrenci (FK, Students tablosuna bağlı).
- `course_id`: Devamsızlık yapılan ders (FK, Courses tablosuna bağlı).
- `date`: Devamsızlık yapılan tarih.
- `status`: Devamsızlık durumu ("Present", "Absent", "Late", "Excused" gibi değerler alabilir).

**İlişkiler:**
- Her öğrenci, her ders için birden fazla devamsızlık kaydına sahip olabilir.
- Bir öğrenci birçok derste devamsızlık yapabilir ve her ders için devamsızlık kaydı bulunabilir.

#### 2.5 Departments (Bölümler)
- `id`: Birincil anahtar (PK), benzersiz bölüm kimliği.
- `department_name`: Bölüm adı, örneğin "Matematik", "Fizik" gibi.

**İlişkiler:**
- Her bölümde birden fazla öğretmen ve birden fazla ders bulunabilir.

#### 2.6 Exams (Sınavlar)
- `id`: Birincil anahtar (PK), benzersiz sınav kimliği.
- `course_id`: Sınavın yapıldığı ders (FK, Courses tablosuna bağlı).
- `exam_date`: Sınav tarihi.
- `exam_type`: Sınav türü, örneğin "Midterm", "Final", "Quiz".

**İlişkiler:**
- Her ders için birden fazla sınav yapılabilir.
- Her sınav yalnızca bir derse bağlıdır.

#### 2.7 ExamResults (Sınav Sonuçları)
- `id`: Birincil anahtar (PK), benzersiz sınav sonucu kimliği.
- `student_id`: Sınava giren öğrenci (FK, Students tablosuna bağlı).
- `exam_id`: Sınav kimliği (FK, Exams tablosuna bağlı).
- `score`: Sınav puanı (numerik değer).

**İlişkiler:**
- Her öğrenci, her sınavdan bir sonuç alabilir.
- Bir sınav, birden fazla öğrenci tarafından alınabilir ve her öğrenci bir sınavdan sadece bir sonuç alır.

#### 2.8 Timetable (Ders Programı)
- `id`: Birincil anahtar (PK), benzersiz ders programı kimliği.
- `course_id`: Programda yer alan ders (FK, Courses tablosuna bağlı).
- `day`: Gün, örneğin "Pazartesi".
- `start_time`: Dersin başlangıç saati.
- `end_time`: Dersin bitiş saati.
- `room`: Dersin yapıldığı oda.

**İlişkiler:**
- Ders programı, birden fazla ders için düzenlenebilir.
- Her ders programı kaydı belirli bir gün ve saatte yapılır.

---

### 3. İlişkiler ve Sayısal Kısıtlamalar

- **Students → Departments**: Her öğrenci yalnızca bir bölüme atanır (1:1).
- **Students → AttendanceRecords**: Her öğrenci, her ders için devamsızlık kaydı tutabilir (1).
- **Courses → Teachers**: Her ders yalnızca bir öğretmen tarafından verilir, ancak her öğretmen birden fazla derse sahip olabilir (1).
- **Courses → Departments**: Her ders yalnızca bir bölüme atanır, ancak bir bölümde birden fazla ders olabilir (1).
- **Exams → Courses**: Her ders için birden fazla sınav yapılabilir, ancak her sınav yalnızca bir derse bağlıdır (1).
- **ExamResults → Students → Exams**: Her öğrenci her sınavdan bir sonuç alabilir, bu nedenle öğrenciler ve sınavlar arasındaki ilişki N'dir.

- ![OBS E-R Diyagramı](./OBS.jpg)

