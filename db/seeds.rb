# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Teacher.create(name: 'admin',
                email: '1@1.cn',
                password: '111111',
                password_confirmation: '111111',
                role: 'admin',
                approved: true)

Teacher.create(name: 'teacher',
               email: '2@2.cn',
               password: '111111',
               password_confirmation: '111111')

Student.create(name: 'student',
               email: '3@3.cn',
               password: '111111',
               password_confirmation: '111111')

Student.create(name: 'has_schedule_student',
               email: '4@4.cn',
               password: '111111',
               password_confirmation: '111111')


Student.create(name: 'has_over_timed_schedule_student',
               email: '5@5.cn',
               password: '111111',
               password_confirmation: '111111')

10.times do |n|
  name = Faker::Name.name
  email = "teacher-#{n+1}@ucas.ac.cn"
  password = "111111"
  Teacher.create(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

70.times do |n|
  name = Faker::Name.name
  email = "student-#{n+1}@ucas.ac.cn"
  password = "111111"
  Student.create(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

teachers = Teacher.order(:created_at).take(10)
teachers.each do |teacher|
  5.times do |n|
    weekday = Random.rand(7)
    place = Random.rand(4)
    start_time = Time.new(2000,1,1,Random.rand(1..3)*6,0,0)
    end_time = start_time + 1.hour
    3.times do |nn|
      teacher.locations.create(weekday:weekday, place:place, start_time: (start_time+nn.hour).to_s(:db) , end_time:(end_time+nn.hour).to_s(:db))
    end
  end
end

def create_has_schedule_student(student_id)
 location_size = Location.all.size
  hss = Student.find_by(id: student_id)
  scheduled_student = hss.build_scheduled_student
  locations = []
  Random.rand(1..5).times do |n|
    locations.append(Random.rand(1..location_size))
  end
  locations.uniq!
  locations.each do |l|
    schedule = scheduled_student.schedules.build
    schedule.location = Location.find_by(id: l)
    schedule.description = Faker::Quote.famous_last_words
    schedule.start_time = schedule.location.start_time
    schedule.end_time = schedule.location.end_time
    schedule.teacher = schedule.location.teacher
    schedule.student = hss
    schedule.status = "pending"
    schedule.save
  end

  scheduled_student.status = "pending"
  scheduled_student.save

end

def create_has_over_timed_schedule_student(student_id)
  location_size = Location.all.size
  hotss = Student.find_by(id: student_id)
  scheduled_student = hotss.build_scheduled_student
  schedule = scheduled_student.schedules.build
  schedule.location = Location.find_by(id: Random.rand(1..location_size))
  schedule.description = Faker::Quote.famous_last_words
  schedule.start_time = schedule.location.start_time
  schedule.end_time = schedule.location.end_time
  schedule.teacher = schedule.location.teacher
  schedule.student = hotss
  schedule.status = "pending"
  schedule.save

  if schedule.active?
    schedule.next_start_time = schedule.next_start_time - 1.week
    schedule.save
  end

  scheduled_student.status = 'pending'
  scheduled_student.save

end

students = []
55.times do |n|
  students.append(Random.rand(5..Student.all.size))
end
students.uniq

create_has_over_timed_schedule_student(3)

students[0..30].each do |s|
  create_has_over_timed_schedule_student(s)
end

create_has_schedule_student(2)

students[31..-1].each do |s|
  create_has_schedule_student(s)
end

