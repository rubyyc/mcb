class PagesController < ApplicationController
  before_action :authenticate_teacher!, only: [:teacher_locations, :teacher_schedules]
  before_action :authenticate_student!, only: :student_schedule

  def teacher_locations
    @location = current_teacher.locations.build
  end

  def teacher_schedules
    @schedules = current_teacher.schedules.current.order(:next_start_time)
    @over_time_schedules = current_teacher.schedules.over_time.order(:next_start_time)

  end

  def student_schedule
    @teachers = Teacher.all
  end
end
