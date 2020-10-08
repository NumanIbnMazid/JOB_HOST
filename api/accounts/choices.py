
# GENDER_CHOICES
MALE = 'Male'
FEMALE = 'Female'
OTHER = 'Other'
GENDER_CHOICES = (
    (MALE, 'Male'),
    (FEMALE, 'Female'),
    (OTHER, 'Other'),
)

# BLOOD_GROUP_CHOICES
A_POSITIVE = 'A+'
A_NEGATIVE = 'A-'
B_POSITIVE = 'B+'
B_NEGATIVE = 'B-'
O_POSITIVE = 'O+'
O_NEGATIVE = 'O-'
AB_POSITIVE = 'AB+'
AB_NEGATIVE = 'AB-'
BLOOD_GROUP_CHOICES = (
    (A_POSITIVE, 'A+'),
    (A_NEGATIVE, 'A-'),
    (B_POSITIVE, 'B+'),
    (B_NEGATIVE, 'B-'),
    (O_POSITIVE, 'O+'),
    (O_NEGATIVE, 'O-'),
    (AB_POSITIVE, 'AB+'),
    (AB_NEGATIVE, 'AB-')
)

# ACCOUNT_TYPE_CHOICES
JOB_SEEKER = 'Job Seeker'
EMPLOYER = 'Employer'
ACCOUNT_TYPE_CHOICES = (
    (JOB_SEEKER, 'Job Seeker'),
    (EMPLOYER, 'Employer'),
)

# MARITAL_STATUS_CHOICES
SINGLE = 'Single'
MARRIED = 'Married'
WIDOWED = 'Widowed'
DIVORCED = 'Divorced'
SEPARATED = 'Separated'
MARITAL_STATUS_CHOICES = (
    (SINGLE, 'Single'),
    (MARRIED, 'Married'),
    (WIDOWED, 'Widowed'),
    (DIVORCED, 'Divorced'),
    (SEPARATED, 'Separated'),
)

# JOB_LEVEL_CHOICES
ENTRY_LEVEL = 'Entry Level'
MID_LEVEL = 'Mid Level'
TOP_LEVEL = 'Top Level'
JOB_LEVEL_CHOICES = (
    (ENTRY_LEVEL, 'Entry Level'),
    (MID_LEVEL, 'Mid Level'),
    (TOP_LEVEL, 'Top Level'),
)

# EMPLOYMENT_TYPE_CHOICES
FULL_TIME = 'Full Time'
PART_TIME = 'Part Time'
INTERNSHIP = 'Internship'
CONTRACT = 'Contract'
FREELANCE = 'Freelance'
THIRD_PARTY = 'Third Party'
EMPLOYMENT_TYPE_CHOICES = (
    (FULL_TIME, 'Full Time'),
    (PART_TIME, 'Part Time'),
    (INTERNSHIP, 'Internship'),
    (CONTRACT, 'Contract'),
    (FREELANCE, 'Freelance'),
    (THIRD_PARTY, 'Third Party'),
)

# SALARY_SCHEDULE_CHOICES
YEAR = 'Year'
MONTH = 'Month'
WEEK = 'Week'
DAY = 'Day'
HOUR = 'Hour'
SALARY_SCHEDULE_CHOICES = (
    (YEAR, 'Year'),
    (MONTH, 'Month'),
    (WEEK, 'Week'),
    (DAY, 'Day'),
    (HOUR, 'Hour'),
)

# EDUCATION_LEVEL_CHOICES
VOCATIONAL = 'Vocational'
HIGH_SCHOOL = 'High School'
ASSOCIATE = 'Associate'
BACHELORS = 'Bachelors'
POST_MASTERS_PRE_DOCTORATE = 'Post Masters, Pre Doctorate'
PRE_BACHELORS = 'Pre Bachelors'
MASTERS = 'Masters'
DOCTORATE = 'Doctorate'
MBA = 'MBA'
POST_BACHELORS_PRE_MASTERS = 'Post Bachelors, Pre Masters'
MILITARY_SERVICE = 'Military Service'
EDUCATION_LEVEL_CHOICES = (
    (VOCATIONAL, 'Vocational'),
    (HIGH_SCHOOL, 'High School'),
    (ASSOCIATE, 'Associate'),
    (BACHELORS, 'Bachelors'),
    (POST_MASTERS_PRE_DOCTORATE, 'Post Masters, Pre Doctorate'),
    (PRE_BACHELORS, 'Pre Bachelors'),
    (MASTERS, 'Masters'),
    (DOCTORATE, 'Doctorate'),
    (MBA, 'MBA'),
    (POST_BACHELORS_PRE_MASTERS, 'Post Bachelors, Pre Masters'),
    (MILITARY_SERVICE, 'Military Service'),
)

# EDUCATION_RESULT_CHOICES
FIRST_DIVISION = 'First Division/Class'
SECOND_DIVISION = 'Second Division/Class'
THIRD_DIVISION = 'Third Division/Class'
GRADE = 'Grade'
APPEARED = 'Appeared'
ENROLLED = 'Enrolled'
AWARDED = 'Awarded'
PASS = 'Pass'
DO_NOT_MENTION = 'Do not mention'
EDUCATION_RESULT_CHOICES = (
    (FIRST_DIVISION, 'First Division/Class'),
    (SECOND_DIVISION, 'Second Division/Class'),
    (THIRD_DIVISION, 'Third Division/Class'),
    (GRADE, 'Grade'),
    (APPEARED, 'Appeared'),
    (ENROLLED, 'Enrolled'),
    (AWARDED, 'Awarded'),
    (PASS, 'Pass'),
    (DO_NOT_MENTION, 'Do not mention'),
)

# SKILL_EXPERIENCE_CHOICES
LESS_THAN_ONE_YEAR = 'Less Than 1 Year'
ONE = '1 Year'
TWO = '2 Years'
THREE = '3 Years'
FOUR = '4 Years'
FIVE = '5 Years'
SIX = '6 Years'
SEVEN = '7 Years'
EIGHT = '8 Years'
NINE = '9 Years'
TEN = '10 Years'
ELEVEN = '11 Years'
TWELVE = '12 Years'
THIRTEEN = '13 Years'
FOURTEEN = '14 Years'
FIFTEEN = '15 Years'
SIXTEEN = '16 Years'
SEVENTEEN = '17 Years'
EIGHTEEN = '18 Years'
NINETEEN = '19 Years'
TWENTY_YEARS_PLUS = '20 Years+'
SKILL_EXPERIENCE_CHOICES = (
    (LESS_THAN_ONE_YEAR, 'Less Than 1 Year'),
    (ONE, '1 Year'),
    (TWO, '2 Years'),
    (THREE, '3 Years'),
    (FOUR, '4 Years'),
    (FIVE, '5 Years'),
    (SIX, '6 Years'),
    (SEVEN, '7 Years'),
    (EIGHT, '8 Years'),
    (NINE, '9 Years'),
    (TEN, '10 Years'),
    (ELEVEN, '11 Years'),
    (TWELVE, '12 Years'),
    (THIRTEEN, '13 Years'),
    (FOURTEEN, '14 Years'),
    (FIFTEEN, '15 Years'),
    (SIXTEEN, '16 Years'),
    (SEVENTEEN, '17 Years'),
    (EIGHTEEN, '18 Years'),
    (NINETEEN, '19 Years'),
    (TWENTY_YEARS_PLUS, '20 Years+'),
)


# LANGUAGE_PROFICIENCY_CHOICES
BASIC_KNOWLEDGE = 'Basic Knowledge'
CONVERSANT = 'Conversant'
PROFICIENT = 'Proficient'
FLUENT = 'Fluent'
NATIVE = 'Native'
BILINGUAl = 'Bilingual'
LANGUAGE_PROFICIENCY_CHOICES = (
    (BASIC_KNOWLEDGE, 'Basic Knowledge'),
    (CONVERSANT, 'Conversant'),
    (PROFICIENT, 'Proficient'),
    (FLUENT, 'Fluent'),
    (NATIVE, 'Native'),
    (BILINGUAl, 'Bilingual'),
)

# LANGUAGE_DIFFICULTY_LEVEL_CHOICES
NOVICE = 'Novice'
INTERMIDIATE = 'Intermidiate'
ADVANCED = 'Advanced'
SUPERIOR = 'Superior'
LANGUAGE_DIFFICULTY_LEVEL_CHOICES = (
    (NOVICE, 'Novice'),
    (INTERMIDIATE, 'Intermidiate'),
    (ADVANCED, 'Advanced'),
    (SUPERIOR, 'Superior'),
)
