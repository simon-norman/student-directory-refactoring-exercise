class Student
  attr_reader :first_name, :surname, :cohort, :birthplace

  def initialize(first_name:, surname:, cohort:, birthplace:)
    @first_name = first_name
    @surname = surname
    @cohort = cohort
    @birthplace = birthplace
  end
end