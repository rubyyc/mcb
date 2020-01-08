class Students::SchedulesController < ApplicationController
  before_action :authenticate_student!, only: [:new, :create,:renew, :destroy]

  def new
    @schedule = current_student.build_schedule
  end

  def create
    @schedule = current_student.build_schedule
    @schedule.description = schedule_params['description']
    @schedule.location = Location.find_by(id: schedule_params['location'])
    @schedule.start_time = @schedule.location.start_time
    @schedule.end_time = @schedule.location.end_time
    @schedule.teacher = @schedule.location.teacher
    respond_to do |format|
      if @schedule.save
        format.html { redirect_to student_schedule_path, notice: "New schedule created!" }
      else
        format.html { render new_students_schedule_path }
      end
    end
  end

  def destroy
    @schedule = current_student.schedule
    @schedule.destroy
    respond_to do |format|
      format.html {redirect_to student_schedule_path, notice: "Schedule has destroyed."}
    end
  end

  def renew
    @schedule = current_student.schedules.active[0]
    @schedule.update(scheduled_times: @schedule.scheduled_times+1, next_start_time: @schedule.next_start_time + 1.week)
    respond_to do |format|
      format.html {redirect_to students_schedule_path, notice: "Schedule has already renewed."}
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit([:description, :location])
  end

end
