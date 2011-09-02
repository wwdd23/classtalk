class StudentsController < ApplicationController
  before_filter :load_group
  
  # GET /students
  # GET /students.xml
  def index
    @students = @group.students
    @student_update = "Now is the time."

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  # GET /students/1
  # GET /students/1.xml
  def show
    @student = @group.students.find(params[:id])
    @grouped_answers = @student.answers.includes(:question).order("questions.destination_id, questions.order_index").group_by {|a| a.question.try(:destination)}
    #you can't easily do #includes through a :includes, you'll still have a bit of n+1 on getting the associated destinations. ah well.

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/new
  # GET /students/new.xml
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.xml
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        @group.students << @student unless @group.students.include? @student
        format.html { redirect_to(group_url(@group), :notice => 'Member was successfully created.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.xml
  def update
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(group_students_url(@group), :notice => 'Member was successfully updated.') }
        format.js
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.xml
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(group_students_url(@group)) }
      format.xml  { head :ok }
    end
  end
  
  private
  def load_group
    if params[:group_id]
    @group = Group.find(params[:group_id])
    elsif
      @group = Group.find(params[:student][:group_id])
    end
  end
end