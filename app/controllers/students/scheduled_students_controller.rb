class Students::ScheduledStudentsController < ApplicationController
  before_action :authenticate_student!, only: [:new, :create, :destroy]
  def new
    if current_student.schedules.any?
      respond_to do |format|
        format.html {redirect_to root_url, notice: "You already have a schedule."}
      end
    end
    @scheduled_student = current_student.build_scheduled_student
  end

  def create
    @scheduled_student = current_student.build_scheduled_student
    @scheduled_student.status = "pending"
    locations = scheduled_student_params[:locations]
    locations.keys.each do |l|
      if locations[l] == "1"
        schedule = @scheduled_student.schedules.build
        schedule.student = current_student
        schedule.location = Location.find_by(id: l)
        schedule.description = scheduled_student_params[:description]
        schedule.start_time = schedule.location.start_time
        schedule.end_time = schedule.location.end_time
        schedule.teacher = schedule.location.teacher
        schedule.status = "pending"
        schedule.save
      end
    end

    if @scheduled_student.save
      respond_to do |format|
        format.html {redirect_to root_url, notice: "New schedule created! "}
      end
    else
      respond_to do |format|
        format.html {redirect_to root_url, alert: "Cannot creat new schedule!"}
      end
    end

  end

  def destroy
    @scheduled_student = current_student.scheduled_student
    @scheduled_student.destroy
    respond_to do |format|
      format.html {redirect_to root_url, notice: "Your schedule has destroyed!"}
    end

  end

  private

  def scheduled_student_params
    params.require(:schedule).permit(:description, locations: {})
  end
end
